"""
ATS Detection Script
Visits each custom_ats company's careers page and fingerprints the underlying ATS
from URL redirects, HTML content, and apply link hrefs.

Run: python3 detect_ats.py
Output: ats_detection_results.csv
"""

import csv
import requests
import re
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from urllib.parse import urlparse

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
        "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
    ),
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
}

# ATS fingerprints: (pattern_to_search, ats_name, notes)
# Checked against: final URL after redirects + raw HTML
ATS_FINGERPRINTS = [
    # URL-based (redirect destination)
    (r"greenhouse\.io",          "greenhouse",        "Greenhouse job board"),
    (r"boards\.greenhouse\.io",  "greenhouse",        "Greenhouse boards"),
    (r"lever\.co",               "lever",             "Lever"),
    (r"ashbyhq\.com",            "ashby",             "Ashby"),
    (r"myworkdayjobs\.com",      "workday",           "Workday"),
    (r"icims\.com",              "icims",             "iCIMS"),
    (r"smartrecruiters\.com",    "smartrecruiters",   "SmartRecruiters"),
    (r"successfactors\.(eu|com)","successfactors",    "SAP SuccessFactors"),
    (r"taleo\.net",              "taleo",             "Oracle Taleo"),
    (r"bamboohr\.com",           "bamboohr",          "BambooHR"),
    (r"rippling\.com/jobs",      "rippling",          "Rippling"),
    (r"jobvite\.com",            "jobvite",           "Jobvite"),
    (r"recruiting\.ultipro\.com","ultipro",           "UltiPro"),
    (r"paylocity\.com",          "paylocity",         "Paylocity"),
    (r"workable\.com",           "workable",          "Workable"),
    (r"recruitee\.com",          "recruitee",         "Recruitee"),
    (r"pinpointhq\.com",         "pinpoint",          "Pinpoint"),
    (r"dover\.com",              "dover",             "Dover"),
    (r"personio\.com",           "personio",          "Personio"),
    (r"jobs\.oracle\.com",       "oracle_jobs",       "Oracle Jobs"),
    (r"careers\.oracle\.com",    "oracle_jobs",       "Oracle Careers"),
    (r"oraclecloud\.com",        "oracle_hcm",        "Oracle HCM Cloud"),
    (r"careers\.sap\.com",       "sap_careers",       "SAP Careers"),
    (r"phenom\.com",             "phenom",            "Phenom"),
    (r"eightfold\.ai",           "eightfold",         "Eightfold AI"),
    (r"hiring\.amazon\.com",     "amazon",            "Amazon Jobs"),
    (r"jobs\.apple\.com",        "apple",             "Apple Jobs"),
    (r"careers\.google\.com",    "google",            "Google Careers"),
    (r"metacareers\.com",        "meta",              "Meta Careers"),
    (r"careers\.microsoft\.com", "microsoft",         "Microsoft Careers"),

    # HTML content fingerprints (script/embed patterns)
    (r"greenhouse-job-board",    "greenhouse",        "Greenhouse embed"),
    (r"grnh\.se",                "greenhouse",        "Greenhouse short URL"),
    (r"lever-jobs-embed",        "lever",             "Lever embed"),
    (r"ashby-job-board",         "ashby",             "Ashby embed"),
    (r"workday\.com/api",        "workday",           "Workday API"),
    (r"icims\.com/jobs",         "icims",             "iCIMS jobs"),
    (r"smartrecruiters\.com/js", "smartrecruiters",   "SmartRecruiters JS"),
    (r"careers-page\.bamboohr",  "bamboohr",          "BambooHR careers"),
    (r"jobvite\.com/api",        "jobvite",           "Jobvite API"),
]

# Known careers page URL patterns per company (used as fallback search)
KNOWN_CAREERS_URLS = {
    "Atlassian":        "https://www.atlassian.com/company/careers",
    "Monday.com":       "https://monday.com/jobs",
    "Coda":             "https://coda.io/about/jobs",
    "Box":              "https://www.box.com/en-us/about-us/careers",
    "Canva":            "https://www.canva.com/careers/",
    "Grammarly":        "https://www.grammarly.com/jobs",
    "DocuSign":         "https://www.docusign.com/company/careers",
    "Freshworks":       "https://www.freshworks.com/company/careers/",
    "Salesforce":       "https://www.salesforce.com/company/careers/",
    "ServiceNow":       "https://www.servicenow.com/careers.html",
    "SAP":              "https://www.sap.com/about/careers.html",
    "Oracle":           "https://www.oracle.com/corporate/careers/",
    "OneLogin":         "https://www.onelogin.com/company/careers",
    "Palo Alto Networks": "https://www.paloaltonetworks.com/company/careers",
    "SentinelOne":      "https://www.sentinelone.com/jobs/",
    "Fortinet":         "https://www.fortinet.com/corporate/about-us/careers",
    "Tenable":          "https://www.tenable.com/careers",
    "Rapid7":           "https://www.rapid7.com/company/careers/",
    "GitHub":           "https://github.com/about/careers",
    "HashiCorp":        "https://www.hashicorp.com/careers",
    "SendGrid":         "https://sendgrid.com/careers/",
    "Segment":          "https://segment.com/jobs/",
    "Retool":           "https://retool.com/careers",
    "Hugging Face":     "https://apply.workable.com/huggingface/",
    "Mistral AI":       "https://mistral.ai/careers/",
    "Character.AI":     "https://character.ai/careers",
    "Adept AI":         "https://www.adept.ai/careers",
    "Glean":            "https://www.glean.com/careers",
    "Weights & Biases": "https://wandb.ai/site/careers",
    "Square (Block)":   "https://block.xyz/careers",
    "PayPal":           "https://careers.pypl.com/home",
    "Wise":             "https://www.wise.jobs/",
    "Klarna":           "https://www.klarna.com/careers/",
    "Avant":            "https://www.avant.com/careers/",
    "Rippling":         "https://www.rippling.com/careers",
    "Revolut":          "https://www.revolut.com/en-US/careers",
    "MoneyLion":        "https://www.moneylion.com/careers/",
    "Uber":             "https://jobs.uber.com/en/jobs/",
    "DoorDash":         "https://careers.doordash.com/",
    "Snap":             "https://careers.snap.com/",
    "Hinge":            "https://hinge.co/careers",
    "Headspace":        "https://www.headspace.com/careers",
    "Yelp":             "https://www.yelp.com/careers",
    "Expedia":          "https://lifeatexpedia.com/",
    "Booking.com":      "https://careers.booking.com/",
    "Etsy":             "https://careers.etsy.com/",
    "Wayfair":          "https://www.wayfair.com/careers/",
    "Whatnot":          "https://www.whatnot.com/careers",
    "GOAT":             "https://www.goat.com/careers",
    "ThredUp":          "https://www.thredup.com/pg/careers",
    "GoodRx":           "https://www.goodrx.com/jobs",
    "Devoted Health":   "https://www.devoted.com/careers",
    "Cityblock Health": "https://www.cityblock.com/careers",
    "Bright Health":    "https://brighthealthgroup.com/careers/",
    "Chegg":            "https://careers.chegg.com/",
    "Guild Education":  "https://www.guildeducation.com/careers/",
    "Codecademy":       "https://www.codecademy.com/about/careers",
    "LeetCode":         "https://leetcode.com/jobs/",
    "Quizlet":          "https://quizlet.com/jobs",
    "Shopify":          "https://www.shopify.com/careers",
    "BigCommerce":      "https://www.bigcommerce.com/careers/",
    "Wix":              "https://www.wix.com/jobs/locations/tel-aviv",
    "ShipBob":          "https://www.shipbob.com/careers/",
    "Afterpay":         "https://www.afterpay.com/en-US/careers",
    "Rakuten":          "https://rakuten.jobs/",
    "Mercado Libre":    "https://jobs.mercadolibre.com/",
    "Fiverr":           "https://www.fiverr.com/jobs",
    "Care.com":         "https://www.care.com/en-us/about/careers",
    "Turo":             "https://turo.com/us/en/careers",
    "Getaround":        "https://www.getaround.com/careers",
    "VRBO":             "https://www.vrbo.com/en-us/p/careers",
    "Resy":             "https://resy.com/careers",
    "Grubhub":          "https://careers.grubhub.com/",
    "Compass":          "https://www.compass.com/careers/",
    "Zillow":           "https://www.zillow.com/careers/",
    "Redfin":           "https://www.redfin.com/about/jobs",
    "Opendoor":         "https://www.opendoor.com/w/careers",
    "Offerpad":         "https://www.offerpad.com/careers/",
    "Better.com":       "https://better.com/careers",
    "Procore":          "https://careers.procore.com/",
    "Convoy":           "https://convoy.com/careers/",
    "BambooHR":         "https://www.bamboohr.com/about/careers/",
    "Lever":            "https://www.lever.co/careers",
    "Shopify":          "https://www.shopify.com/careers",
}


def detect_ats_from_text(text: str, url: str) -> tuple:
    """Returns (ats_name, evidence) or (None, None)"""
    combined = (url + " " + text).lower()
    for pattern, ats_name, notes in ATS_FINGERPRINTS:
        if re.search(pattern, combined, re.IGNORECASE):
            match = re.search(pattern, combined, re.IGNORECASE)
            return ats_name, f"{notes} — matched: {match.group()}"
    return None, None


def check_company(company_name: str, careers_url: str) -> dict:
    result = {
        "company": company_name,
        "careers_url": careers_url,
        "detected_ats": None,
        "evidence": None,
        "final_url": None,
        "error": None,
    }

    try:
        resp = requests.get(
            careers_url, headers=HEADERS, timeout=15,
            allow_redirects=True
        )
        final_url = resp.url
        result["final_url"] = final_url
        html = resp.text[:50000]  # first 50KB is enough

        # 1. Check final URL after redirects
        ats, evidence = detect_ats_from_text("", final_url)
        if ats:
            result["detected_ats"] = ats
            result["evidence"] = f"URL redirect → {final_url}"
            return result

        # 2. Check HTML body
        ats, evidence = detect_ats_from_text(html, "")
        if ats:
            result["detected_ats"] = ats
            result["evidence"] = evidence
            return result

        # 3. Try to find any apply/jobs links in HTML and check those URLs
        links = re.findall(r'href=["\']([^"\']+)["\']', html)
        for link in links:
            ats, evidence = detect_ats_from_text("", link)
            if ats:
                result["detected_ats"] = ats
                result["evidence"] = f"Apply link → {link}"
                return result

        result["detected_ats"] = "unknown"
        result["evidence"] = f"No ATS fingerprint found. Final URL: {final_url}"

    except Exception as e:
        result["detected_ats"] = "error"
        result["error"] = str(e)

    return result


def build_search_url(company_name: str) -> str:
    """Fallback: search for company careers page via Google-style URL"""
    slug = company_name.lower().replace(" ", "-").replace(".", "").replace("(", "").replace(")", "").replace("&", "and")
    return f"https://www.{slug}.com/careers"


def main():
    # Load custom_ats companies
    companies = []
    with open("company_master_list.csv") as f:
        for row in csv.DictReader(f):
            if row["status"] == "custom_ats":
                name = row["company_name"]
                url = KNOWN_CAREERS_URLS.get(name) or build_search_url(name)
                companies.append((name, url))

    print(f"Detecting ATS for {len(companies)} companies with 30 workers...\n")

    results = []
    with ThreadPoolExecutor(max_workers=30) as executor:
        futures = {executor.submit(check_company, name, url): name for name, url in companies}
        for i, future in enumerate(as_completed(futures), 1):
            r = future.result()
            results.append(r)
            status = r["detected_ats"] or "?"
            print(f"[{i}/{len(companies)}] {r['company']:30s} → {status}")

    # Sort and write output
    results.sort(key=lambda x: (x["detected_ats"] or "zzz", x["company"]))

    with open("ats_detection_results.csv", "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["company", "careers_url", "detected_ats", "evidence", "final_url", "error"])
        writer.writeheader()
        writer.writerows(results)

    # Print summary
    from collections import Counter
    counts = Counter(r["detected_ats"] for r in results)
    print("\n=== ATS BREAKDOWN ===")
    for ats, count in counts.most_common():
        print(f"  {ats:25s} {count:3d} companies")
    print(f"\nFull results saved to ats_detection_results.csv")


if __name__ == "__main__":
    main()
