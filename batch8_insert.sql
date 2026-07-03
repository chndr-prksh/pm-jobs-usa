-- ============================================================
-- BATCH 8: Results from v2 apply-link slug finder
-- Run in Supabase SQL editor
-- ============================================================

-- -------------------------------------------------------
-- WORKDAY
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT '8x8', 'workday', 'https://www.8x8.com/careers', '{"tenant":"8x8inc","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = '8x8');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'RingCentral', 'workday', 'https://www.ringcentral.com/careers', '{"tenant":"ringcentral","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'RingCentral');

-- Slack uses Salesforce Workday tenant (acquired by Salesforce)
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Slack', 'workday', 'https://www.slack.com/careers', '{"tenant":"salesforce","instance":"wd12","search_text":"slack product manager"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Slack');

-- -------------------------------------------------------
-- GREENHOUSE
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Grammarly', 'greenhouse', 'https://www.grammarly.com/jobs', '{"slug":"grammarly"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Grammarly');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Square (Block)', 'greenhouse', 'https://block.xyz/careers', '{"slug":"block"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Square (Block)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Tenable', 'greenhouse', 'https://www.tenable.com/careers', '{"slug":"tenableinc"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Tenable');

-- -------------------------------------------------------
-- LEVER
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Catalant', 'lever', 'https://www.catalant.com/careers', '{"slug":"gocatalant"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Catalant');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Weights & Biases', 'lever', 'https://wandb.ai/site/careers', '{"slug":"wandb"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Weights & Biases');

-- -------------------------------------------------------
-- ASHBY
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Front', 'ashby', 'https://www.front.com/careers', '{"slug":"frontcareers"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Front');

-- -------------------------------------------------------
-- RIPPLING
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rippling', 'rippling', 'https://ats.rippling.com/rippling/jobs', '{"slug":"rippling"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rippling');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Shippo', 'rippling', 'https://ats.rippling.com/shippo/jobs', '{"slug":"shippo"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Shippo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Argyle', 'rippling', 'https://ats.rippling.com/argyle/jobs', '{"slug":"argyle"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Argyle');

-- -------------------------------------------------------
-- SMARTRECRUITERS
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Wix', 'smartrecruiters', 'https://www.wix.com/jobs/locations/tel-aviv', '{"slug":"Wix2"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Wix');

-- -------------------------------------------------------
-- SKIPPED (requires investigation):
-- Ring        → Amazon Jobs (acquired, no standalone scraper)
-- Redfin      → Rocket Companies Workday (complex acquisition)
-- Xoom        → PayPal Eightfold (already covered under PayPal)
-- Paycor      → iCIMS (domain blocked, need manual lookup)
-- Sastrify    → Personio (1 company, low ROI)
-- -------------------------------------------------------
