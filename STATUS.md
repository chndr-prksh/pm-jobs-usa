# Company Status Tracker

Last updated: 2026-07-03 (after commit `68cf8cc`)

This file tracks which companies are actually scraping successfully vs. which
need attention. Update it after each SQL batch and after reviewing workflow
run logs. `jobs.csv` / README.md reflect live scrape output; this file is the
narrative on top of it.

## Snapshot (as of last completed run, before tonight's auto-run)

- **~644 active companies** in the `companies` table
- **282 companies** returned ≥1 PM job in the last run
- **1,521 total jobs** in `jobs.csv`
- **0 known FAILED entries expected** after fixes below — pending verification
  from tonight's scheduled run (2026-07-04 06:00 UTC)

## SQL batches — apply status

| File | Companies | Status |
|---|---|---|
| batch1–batch7 | ~325 | Applied (early manual + first ATS-detection rounds) |
| batch8_insert.sql | 13 | Applied |
| batch9_insert.sql | 432 | Applied |
| batch9_activate.sql | 71 | Applied |
| batch9_activate2.sql | 9 | Applied |
| batch9_fix_slugs.sql | 1 | Applied |
| batch9_deactivate_stuck.sql | 12 | **Confirm applied** |
| batch10_insert.sql | 20 | **Confirm applied** |

## Fixed in code (no SQL needed, live as of commit `552ea0d`)

These were failing in the run before last, fixed by making `scrapers/workday.py`
also parse `Disallow: /{site}/` entries in robots.txt (previously only read
`Sitemap:` lines):

- Nike, Ecolab, Illinois Tool Works, T-Mobile, Palo Alto Networks

Also fixed: O'Reilly Automotive crash on a job posting missing `title` (now
defaults to "Untitled" instead of raising).

## Deactivated — not worth further automation (batch9_deactivate_stuck.sql)

| Company | ATS | Why |
|---|---|---|
| Uber | uber (Playwright) | Cloudflare blocks GitHub Actions IPs even via headless browser |
| MercadoLibre | eightfold (Playwright) | Same Cloudflare block |
| Rippling (the company itself) | rippling | Own board doesn't resolve — likely renamed/removed |
| Reflektive | lever | Slug 404s, likely acquired/shut down |
| Scalapay | lever | Slug 404s |
| Weights & Biases | lever | Slug 404s, likely migrated ATS |
| Statsig | ashby | Slug 404s |
| Cerebras Systems | greenhouse | Slug 404s |
| Credo Technology | greenhouse | Slug 404s |
| Grammarly | greenhouse | Slug 404s, likely migrated ATS |
| Sea Limited | greenhouse | Slug 404s |
| Symbotic | greenhouse | Slug 404s |

**If you want to re-attempt any of these**, the fix path is: find the current
career page manually, click "Apply" on a job, and grab the resulting ATS URL
(the method that worked for batch10).

## Known permanent gaps — no scraper support yet

ATS platforms seen in the wild but not built:
- **Taleo** (Boeing)
- **SuccessFactors** (SAP, Exxon Mobil, Banco Santander, Amrize)
- **Oracle Recruiting Cloud** (Oracle, Vertiv)
- **Gem** (seen via jobs.gem.com — Luma Labs)
- **Paycom** (a specific company's ATS, not to be confused with Paycor/iCIMS)
- **Custom in-house career sites** (Amazon, Apple, Meta, Google, Microsoft, and
  most non-US-HQ multinationals — ~54 companies from the Fortune-500 batch)

These are parked, not actively being chased. Would need a dedicated scraper
per platform if prioritized.

## Ambiguous — needs manual check

- **"Range"**: exists in DB as Greenhouse (`range` slug, added early). A
  LinkedIn apply-link later pointed to `jobs.ashbyhq.com/range` — could be a
  same-named different company or a migrated ATS. Not resolved either way.

## ~280 companies still unresolved from the original Fortune-500 batch

Most of the 302 Workday companies whose tenant slug couldn't be guessed/verified
in the first two automation passes remain untouched (`active=false`, empty
`ats_config`). See `workday_slug_verification.csv` and
`workday_variants_found.csv` for what was already tried. The user is doing
manual lookup on these via LinkedIn apply-links (see batch10 methodology) as
time allows — no automated next step planned unless requested.
