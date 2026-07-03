"""
Verify guessed Workday tenant slugs using the scraper's own resolver.
For each of the 294 inactive Workday companies, run _resolve() to find a
working (instance, site) pair. Output SQL to activate the ones that work.

Run: python3 verify_workday_slugs.py
Output: workday_slug_verification.csv + batch9_activate.sql
"""

import csv
import json
import re
import concurrent.futures
from scrapers.workday import _resolve

# company_name -> guessed tenant (from batch9 generation)
def load_targets():
    """Parse batch9_insert.sql for the inactive Workday rows (active=false with tenant)."""
    targets = {}
    sql = open("batch9_insert.sql").read()
    pattern = re.compile(
        r"SELECT '((?:[^']|'')+)', 'workday', '(?:[^']|'')+', '(\{[^}]*\})'::jsonb, false"
    )
    for m in pattern.finditer(sql):
        name = m.group(1).replace("''", "'")
        cfg = json.loads(m.group(2))
        if cfg.get("tenant"):
            targets[name] = cfg["tenant"]
    return targets


def check(name, tenant):
    try:
        inst, site = _resolve(tenant, None, None)
        return name, tenant, inst, site, None
    except Exception as e:
        return name, tenant, None, None, str(e)[:80]


def main():
    targets = load_targets()
    print(f"Verifying {len(targets)} guessed Workday tenants...\n")

    results = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=12) as ex:
        futures = {ex.submit(check, n, t): n for n, t in targets.items()}
        done = 0
        for fut in concurrent.futures.as_completed(futures):
            name, tenant, inst, site, err = fut.result()
            done += 1
            results.append({"company_name": name, "tenant": tenant,
                            "instance": inst or "", "site": site or "",
                            "error": err or ""})
            status = f"✓ {tenant}.{inst} site={site}" if inst else "✗"
            print(f"[{done:3d}/{len(targets)}] {name:42s} {status}")

    results.sort(key=lambda r: r["company_name"])
    with open("workday_slug_verification.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=["company_name", "tenant", "instance", "site", "error"])
        w.writeheader()
        w.writerows(results)

    verified = [r for r in results if r["instance"]]
    with open("batch9_activate.sql", "w") as f:
        f.write("-- Activate Workday companies whose guessed tenant slug verified OK\n")
        f.write("-- (instance + site confirmed against live Workday API)\n\n")
        for r in verified:
            n = r["company_name"].replace("'", "''")
            cfg = json.dumps({"tenant": r["tenant"], "instance": r["instance"], "site": r["site"]})
            f.write(
                f"UPDATE companies SET active = true, ats_config = '{cfg}'::jsonb "
                f"WHERE company_name = '{n}' AND ats = 'workday';\n"
            )

    print(f"\nVerified: {len(verified)} / {len(targets)}")
    print("Wrote workday_slug_verification.csv and batch9_activate.sql")


if __name__ == "__main__":
    main()
