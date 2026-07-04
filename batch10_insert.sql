-- ============================================================
-- BATCH 10: Companies found via LinkedIn "Apply" link scraping
-- Source: user manually clicked Apply on PM job postings on LinkedIn
-- All slugs verified live against the ATS public API before insert.
-- ============================================================

-- -------------------------------------------------------
-- ASHBY
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Grow Therapy', 'ashby', 'https://jobs.ashbyhq.com/grow-therapy', '{"slug":"grow-therapy"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Grow Therapy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Polymarket', 'ashby', 'https://jobs.ashbyhq.com/polymarket', '{"slug":"polymarket"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Polymarket');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rogo', 'ashby', 'https://jobs.ashbyhq.com/Rogo', '{"slug":"Rogo"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rogo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Maven AGI', 'ashby', 'https://jobs.ashbyhq.com/maven-agi', '{"slug":"maven-agi"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Maven AGI');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Finalis', 'ashby', 'https://jobs.ashbyhq.com/finalis', '{"slug":"finalis"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Finalis');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Campus', 'ashby', 'https://jobs.ashbyhq.com/campus', '{"slug":"campus"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Campus');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bobyard', 'ashby', 'https://jobs.ashbyhq.com/bobyard', '{"slug":"bobyard"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bobyard');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Decagon', 'ashby', 'https://jobs.ashbyhq.com/decagon', '{"slug":"decagon"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Decagon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Benepass', 'ashby', 'https://jobs.ashbyhq.com/benepass', '{"slug":"benepass"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Benepass');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EliseAI', 'ashby', 'https://jobs.ashbyhq.com/eliseai', '{"slug":"eliseai"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EliseAI');

-- -------------------------------------------------------
-- GREENHOUSE
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MomoGood', 'greenhouse', 'https://job-boards.greenhouse.io/momogood', '{"slug":"momogood"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MomoGood');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Tekmetric', 'greenhouse', 'https://job-boards.greenhouse.io/tekmetric', '{"slug":"tekmetric"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Tekmetric');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fluxon', 'greenhouse', 'https://job-boards.greenhouse.io/fluxon', '{"slug":"fluxon"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fluxon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kikoff', 'greenhouse', 'https://job-boards.greenhouse.io/kikoff', '{"slug":"kikoff"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kikoff');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Clear', 'greenhouse', 'https://job-boards.greenhouse.io/clear', '{"slug":"clear"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Clear');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AcuityMD', 'greenhouse', 'https://job-boards.greenhouse.io/acuitymd', '{"slug":"acuitymd"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AcuityMD');

-- -------------------------------------------------------
-- RIPPLING
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Comp AI', 'rippling', 'https://ats.rippling.com/comp-ai/jobs', '{"slug":"comp-ai"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Comp AI');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Harell Data', 'rippling', 'https://ats.rippling.com/harelldata/jobs', '{"slug":"harelldata"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Harell Data');

-- -------------------------------------------------------
-- WORKDAY — exact site path taken from the LinkedIn apply URL itself
-- (auto-discovery failed: these sites aren't listed in robots.txt)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TherapyBrands (Ensora Health)', 'workday',
       'https://therapybrands.wd1.myworkdayjobs.com/EnsoraHealth',
       '{"tenant":"therapybrands","instance":"wd1","site":"EnsoraHealth"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TherapyBrands (Ensora Health)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MRI Software', 'workday',
       'https://mrisoftware.wd501.myworkdayjobs.com/External_CareerSite',
       '{"tenant":"mrisoftware","instance":"wd501","site":"External_CareerSite"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MRI Software');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'First American', 'workday',
       'https://firstam.wd1.myworkdayjobs.com/firstamericancareers',
       '{"tenant":"firstam","instance":"wd1","site":"firstamericancareers"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'First American');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Snap Finance', 'workday',
       'https://snapfinance.wd1.myworkdayjobs.com/Snap_External_Careers',
       '{"tenant":"snapfinance","instance":"wd1","site":"Snap_External_Careers"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Snap Finance');

-- -------------------------------------------------------
-- SKIPPED — already in the DB and scraping successfully:
--   DailyPay (ashby), Rho (ashby), Superhuman (ashby),
--   Toast (greenhouse), Pendo (greenhouse), Mixpanel (greenhouse)
--
-- AMBIGUOUS — needs manual check before adding:
--   "Range" exists as Greenhouse (slug: range), but LinkedIn link
--   points to jobs.ashbyhq.com/range — could be a different company
--   with the same name, or a migrated ATS. Not auto-resolved.
--
-- UNSUPPORTED ATS (no scraper built):
--   Valon (custom domain + ashby_jid param, no public slug in URL)
--   Mercor (custom domain + ashby_jid param, no public slug in URL)
--   jobs.gem.com (Gem ATS) — Luma Labs
--   paycomonline.net (Paycom ATS, different from Paycor)
--   jobs.lumion.ai (custom/unknown platform)
--   career.odevo.com (custom/unknown platform)
--   workatastartup.com — generic YC job board, not company-specific
-- -------------------------------------------------------
