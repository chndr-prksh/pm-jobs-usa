"""
Second-pass Workday tenant finder: tries slug variants for companies whose
first guess failed. Existence is checked via robots.txt (fast 404 on miss),
then the jobs endpoint is verified and the best site picked by job count.

Run: python3 find_workday_variants.py
Output: workday_variants_found.csv + batch9_activate2.sql
"""

from __future__ import annotations

import csv
import json
import re
import concurrent.futures
import requests
from scrapers.workday import _sites_from_robots, HEADERS, INSTANCE_CANDIDATES

# Hand-curated tenants for companies whose slug is non-obvious
KNOWN = {
    "American Express": ["aexp"],
    "Anheuser-Busch InBev": ["abinbevna", "anheuserbuschinbev"],
    "Bank of Nova Scotia": ["bns"],
    "BNY Mellon": ["bnymellon", "bny"],
    "Boston Scientific": ["bsci"],
    "Charles Schwab": ["schwabjobs", "cs"],
    "Citigroup": ["citi", "citigroup"],
    "Coca-Cola": ["coke", "ko", "tccc"],
    "Colgate-Palmolive": ["colpal"],
    "Deere": ["deere", "johndeere"],
    "Delta Air Lines": ["delta", "deltaairlines"],
    "Electronic Arts": ["ea", "electronicarts"],
    "Estee Lauder": ["elc", "esteelauder"],
    "Ford Motor": ["ford", "fordmotor"],
    "GE Aerospace": ["geaerospace", "ge"],
    "General Dynamics": ["gd", "gdit", "generaldynamics"],
    "Goldman Sachs": ["gs", "goldmansachs"],
    "HCA Healthcare": ["hcahealthcare", "hca"],
    "IBM": ["ibm", "ibmcareers"],
    "Intercontinental Exch": ["ice", "intercontinentalexchange", "theice"],
    "JPMorgan Chase": ["jpmc", "jpmorganchase"],
    "Kroger": ["kroger", "krogerco"],
    "Lockheed Martin": ["lmco", "lockheedmartin", "lm"],
    "Lowe's": ["lowes", "lowesinc"],
    "Marriott": ["marriott", "marriottinternational", "mi"],
    "McDonald's": ["mcd", "mcdonalds", "mcdonaldscorporation"],
    "MetLife": ["metlife", "metlifecareers"],
    "Morgan Stanley": ["morganstanley", "ms"],
    "Norfolk Southern": ["nscorp", "norfolksouthern", "ns"],
    "Northrop Grumman": ["northropgrumman", "ngc"],
    "PayPal": ["paypal", "pypl"],
    "PepsiCo": ["pepsico", "pep"],
    "PG&E": ["pge", "pgecorp"],
    "Philip Morris Intl": ["pmi", "philipmorris", "pmintl"],
    "Rio Tinto": ["riotinto", "riotintocareers"],
    "SLB (Schlumberger)": ["slb", "schlumberger"],
    "Starbucks": ["starbucks", "sbux"],
    "Thermo Fisher": ["thermofisher", "tmo"],
    "UPS": ["ups", "upsjobs"],
    "Union Pacific": ["up", "unionpacific", "uprr"],
    "UnitedHealth (Optum)": ["uhg", "unitedhealthgroup", "optum"],
    "United Airlines": ["united", "unitedairlines", "ual"],
    "Wells Fargo": ["wellsfargo", "wf", "wellsfargojobs"],
    "Waste Management": ["wm", "wastemanagement"],
    "Yum! Brands": ["yum", "yumbrands"],
}

SUFFIXES = ["", "inc", "corp", "co", "group", "global", "careers", "jobs", "us", "usa", "1", "2"]


def variants_for(name: str, base: str) -> list[str]:
    out = []
    seen = set()

    def add(v):
        v = v.strip("-")
        if v and v not in seen:
            seen.add(v)
            out.append(v)

    for k in KNOWN.get(name, []):
        add(k)

    words = re.sub(r"[^a-z0-9 ]", " ", name.lower().replace("'", "")).split()
    joined = "".join(words)
    hyphen = "-".join(words)
    first = words[0] if words else base
    initials = "".join(w[0] for w in words if w)

    for stem in [base, joined, first]:
        for suf in SUFFIXES:
            add(stem + suf)
    add(hyphen)
    if len(initials) >= 2:
        add(initials)
    add("the" + joined)
    return out


def tenant_exists(tenant: str) -> str | None:
    """Return the instance where this tenant's robots.txt lists site maps, else None."""
    for inst in INSTANCE_CANDIDATES:
        try:
            r = requests.get(
                f"https://{tenant}.{inst}.myworkdayjobs.com/robots.txt",
                headers={"User-Agent": HEADERS["User-Agent"]}, timeout=8,
            )
            if r.status_code == 200 and "siteMap" in r.text:
                return inst
        except requests.RequestException:
            continue
    return None


def site_total(tenant, inst, site):
    url = f"https://{tenant}.{inst}.myworkdayjobs.com/wday/cxs/{tenant}/{site}/jobs"
    try:
        r = requests.post(url, json={"appliedFacets": {}, "limit": 1, "offset": 0, "searchText": ""},
                          headers=HEADERS, timeout=10)
        if r.status_code == 200:
            d = r.json()
            if "jobPostings" in d or "total" in d:
                return d.get("total", 0)
    except Exception:
        pass
    return -1


def check_company(row):
    name, base = row["company_name"], row["tenant"]
    for tenant in variants_for(name, base):
        if tenant == base:
            continue  # first pass already proved this fails
        inst = tenant_exists(tenant)
        if not inst:
            continue
        try:
            sites = _sites_from_robots(tenant, inst)
        except Exception:
            continue
        best, best_total = None, -1
        for s in sites:
            t = site_total(tenant, inst, s)
            if t > best_total:
                best, best_total = s, t
        if best and best_total >= 0:
            return name, tenant, inst, best, best_total
    return name, None, None, None, None


def main():
    failed = [r for r in csv.DictReader(open("workday_slug_verification.csv")) if not r["instance"]]
    print(f"Trying slug variants for {len(failed)} companies...\n")

    found = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=12) as ex:
        done = 0
        for res in ex.map(check_company, failed):
            name, tenant, inst, site, total = res
            done += 1
            if tenant:
                found.append(res)
                print(f"[{done:3d}/{len(failed)}] ✓ {name:40s} → {tenant}.{inst}/{site} ({total} jobs)")
            else:
                print(f"[{done:3d}/{len(failed)}] ✗ {name}")

    found.sort()
    with open("workday_variants_found.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["company_name", "tenant", "instance", "site", "total_jobs"])
        w.writerows(found)

    with open("batch9_activate2.sql", "w") as f:
        f.write("-- Second-pass activation: Workday tenants found via slug variants\n\n")
        for name, tenant, inst, site, total in found:
            n = name.replace("'", "''")
            cfg = json.dumps({"tenant": tenant, "instance": inst, "site": site})
            f.write(f"UPDATE companies SET active = true, ats_config = '{cfg}'::jsonb "
                    f"WHERE company_name = '{n}' AND ats = 'workday';\n")

    print(f"\nFound: {len(found)} / {len(failed)}")
    print("Wrote workday_variants_found.csv and batch9_activate2.sql")


if __name__ == "__main__":
    main()
