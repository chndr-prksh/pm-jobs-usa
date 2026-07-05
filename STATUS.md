# Company Status Tracker

Last updated: 2026-07-04 (after commit `fad59a9`)

## Phase 5 — Autonomous Apply Agent (Managed Agents)

- **Environment**: `env_01YVLywryRFCkcCn1ZKpDPvd` (`pm-jobs-apply-agent`, cloud, unrestricted networking — ATS/employer domains aren't enumerable in advance; tighten later once traffic patterns are known)
- **Vault**: `vlt_011CciPfaaLnYEUMF5tRzfRL` (`pm-jobs-apply-agent-secrets`) — holds `SUPABASE_SERVICE_KEY` (scoped to the Supabase host). Telegram token is NOT in the vault (see note below).
- **Agent**: `agent_01LWxTmm4FhbUkdJasYGwoir` (`pm-jobs-apply-agent`, **v5**, Sonnet 5)
  - v2: smoke test passed (Telegram delivery + Supabase REST query)
  - v3: per-ATS playbooks (Greenhouse/Lever/Ashby field patterns), resume/email/account-verification handling
  - v4: Kind A/B question classification — drafts behavioral answers from resume, blocks on factual/personal-status questions
  - v5 (current): **auto-submit** — reverses review-before-submit per explicit user direction. Fills, verifies, clicks Submit for real, captures before/after screenshots to Storage, records `filled_data` JSON, sends Telegram photo + Good/Flag inline buttons
  - **Real-world validated**: successfully filled and reached submission-ready state on a real Spotify Senior PM (Lever) posting across two runs — first hit 2 factual-adjacent essay questions, second run (v4) correctly classified them as Kind A and drafted grounded answers from real work history
- `check_telegram_feedback.py` — polls Telegram for Good/Flag button presses, writes to `application_feedback`. Not yet run against a real auto-submitted application (v5 not yet live-tested for actual submission).
- **Scheduled Deployment**: not yet created — currently invoked manually via `apply_job.py <job_id>`
- Target ATS rollout: Greenhouse, Lever, Ashby only
- Submit mode: **auto-submit, review-after-the-fact via Telegram feedback** (changed from review-before-submit)
- New tables: `application_feedback`, `telegram_poll_state`. New `applications` columns: `filled_data`, `confirmation_screenshot_url`, `submitted_at`
- New Storage bucket: `application-screenshots` (private)
- Note: local dev must use the `venv` (Python 3.14, in `pm-jobs-usa/venv/`), not conda `(base)` — conda's Python 3.8 caps `anthropic` SDK at 0.72.0, which predates Vaults/Managed Agents support
- Note: `TELEGRAM_BOT_TOKEN` is a plain local `.env` var, not a Vault credential — Telegram's Bot API requires the token in the URL path, which Vault `environment_variable` substitution (header/body only) can't support. It's passed directly in each session's first user message instead. Bot: `@pm_jobs_us_bot`, chat ID saved as `TELEGRAM_CHAT_ID`.

This file tracks which companies are actually scraping successfully vs. which
need attention. Update it after each SQL batch and after reviewing workflow
run logs. `jobs.csv` / README.md reflect live scrape output; this file is the
narrative on top of it.

## Snapshot (as of the 2026-07-04 06:00 UTC auto-run — before today's pagination/filter fixes)

- **~644 active companies** in the `companies` table
- **306 companies** returned ≥1 PM job in that run
- **1,655 total jobs** in `jobs.csv`
- Zero `FAILED` entries from the robots.txt fix — confirmed working
- **Two more bugs found and fixed today, not yet reflected in a run:**
  1. Workday pagination stopped early for tenants whose `total` field resets
     to 0 after page 1 (e.g. Accenture reported `total=2000` on offset 0,
     then `total=0` on every later page) — this silently capped ~40+ large
     companies at exactly 40 jobs. Now stops on page-size instead of the
     unreliable `total` field, with a 2000-offset safety cap.
  2. Workday's `searchText` is a fuzzy match, not a title filter — querying
     "product manager" against Accenture returned 2020 results, only ~45 of
     which had an actual PM-like title. Added the same `_is_pm_role()` title
     filter that bamboohr/pinpoint already use. Verified: Accenture goes from
     2020 raw matches → 47 real PM postings.
- **Net effect expected next run**: company/job counts should shift —
  large companies gain real jobs they were missing (capped at 40 before),
  while noisy non-PM titles get filtered out. Watch the next run's numbers
  to confirm this nets positive.

## SQL batches — apply status

| File | Companies | Status |
|---|---|---|
| batch1–batch7 | ~325 | Applied (early manual + first ATS-detection rounds) |
| batch8_insert.sql | 13 | Applied |
| batch9_insert.sql | 432 | Applied |
| batch9_activate.sql | 71 | Applied |
| batch9_activate2.sql | 9 | Applied |
| batch9_fix_slugs.sql | 1 | Applied |
| batch9_deactivate_stuck.sql | 12 | Applied (confirmed via 306-company count matching expectation) |
| batch10_insert.sql | 20 | Applied |

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
