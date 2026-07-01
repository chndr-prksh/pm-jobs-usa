-- ============================================================
-- BATCH 6: Slugs discovered via Playwright slug finder
-- Run in Supabase SQL editor
-- ============================================================

-- -------------------------------------------------------
-- GREENHOUSE
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Teachable', 'greenhouse', 'https://www.teachable.com/careers', '{"slug":"teachablecareers"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Teachable');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MX Technologies', 'greenhouse', 'https://www.mx.com/careers/', '{"slug":"mxtechnologiesinc"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MX Technologies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Glean', 'greenhouse', 'https://www.glean.com/careers', '{"slug":"gleanwork"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Glean');

-- -------------------------------------------------------
-- WORKDAY
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Stord', 'workday', 'https://www.stord.com/careers', '{"tenant":"stord","instance":"wd503"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Stord');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Criteo', 'workday', 'https://careers.criteo.com/en/', '{"tenant":"criteo","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Criteo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Tempus', 'workday', 'https://www.tempus.com/careers/', '{"tenant":"tempus","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Tempus');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Buildertrend', 'workday', 'https://buildertrend.com/careers/', '{"tenant":"buildertrend","instance":"wd108"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Buildertrend');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Wonder', 'workday', 'https://www.wonder.com/careers', '{"tenant":"wonder","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Wonder');

-- -------------------------------------------------------
-- LEVER
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Scalapay', 'lever', 'https://www.scalapay.com/careers', '{"slug":"Scalapay"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Scalapay');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EasyPost', 'lever', 'https://www.easypost.com/careers', '{"slug":"easypost-2"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EasyPost');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Reflektive', 'lever', 'https://www.reflektive.com/company/careers/', '{"slug":"reflektive"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Reflektive');

-- -------------------------------------------------------
-- ASHBY
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'DolarApp', 'ashby', 'https://www.dolarapp.com/careers', '{"slug":"ARQ"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'DolarApp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Empower', 'ashby', 'https://www.empower.me/careers', '{"slug":"tilthq"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Empower');
