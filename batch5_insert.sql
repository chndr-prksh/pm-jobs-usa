-- ============================================================
-- BATCH 5: New companies discovered via deep ATS scan
-- Run in Supabase SQL editor
-- ============================================================

-- -------------------------------------------------------
-- GREENHOUSE (new companies)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Anduril', 'greenhouse', 'https://www.anduril.com/careers', '{"slug":"andurilindustries"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Anduril');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Neue Health (Bright Health)', 'greenhouse', 'https://www.neuehealth.com/careers', '{"slug":"neuehealth"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Neue Health (Bright Health)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GOAT Group', 'greenhouse', 'https://www.goat.com/careers', '{"slug":"goatgroup"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GOAT Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Headspace', 'greenhouse', 'https://www.headspace.com/join-us', '{"slug":"hs"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Headspace');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hippo Insurance', 'greenhouse', 'https://www.hippo.com/careers', '{"slug":"hippo70"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hippo Insurance');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'WeightWatchers', 'greenhouse', 'https://www.weightwatchers.com/us/ww-corporate-careers', '{"slug":"ww"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'WeightWatchers');

-- -------------------------------------------------------
-- WORKDAY (new companies — confirmed slugs)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT '23andMe', 'workday', 'https://www.23andme.com/careers/', '{"tenant":"23andme","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = '23andMe');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BigCommerce', 'workday', 'https://www.bigcommerce.com/careers/', '{"tenant":"bigcommerce","instance":"wd12"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BigCommerce');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cityblock Health', 'workday', 'https://www.cityblock.com/careers', '{"tenant":"cityblockhealth","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cityblock Health');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Devoted Health', 'workday', 'https://www.devoted.com/careers', '{"tenant":"devoted","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Devoted Health');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Grubhub', 'workday', 'https://careers.grubhub.com/', '{"tenant":"wonder","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Grubhub');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Palo Alto Networks', 'workday', 'https://www.paloaltonetworks.com/company/careers', '{"tenant":"paloaltonetworks","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Palo Alto Networks');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Pluralsight', 'workday', 'https://www.pluralsight.com/careers', '{"tenant":"pluralsight","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Pluralsight');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Remitly', 'workday', 'https://careers.remitly.com/', '{"tenant":"remitly","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Remitly');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sunrun', 'workday', 'https://www.sunrun.com/careers', '{"tenant":"sunrun","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sunrun');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Zipcar', 'workday', 'https://www.zipcar.com/jobs', '{"tenant":"avisbudget","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Zipcar');

-- Finicity (acquired by Mastercard — uses Mastercard Workday tenant)
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Finicity', 'workday', 'https://www.finicity.com/careers/', '{"tenant":"mastercard","instance":"wd1","search_text":"finicity product manager"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Finicity');

-- -------------------------------------------------------
-- LEVER (new companies)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Mistral AI', 'lever', 'https://mistral.ai/careers/', '{"slug":"mistral"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Mistral AI');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Side', 'lever', 'https://side.com/careers', '{"slug":"sideinc"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Side');

-- Lever (company itself — uses lever slug)
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lever', 'lever', 'https://www.lever.co/careers', '{"slug":"lever"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lever');

-- -------------------------------------------------------
-- ASHBY (new companies)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Character.AI', 'ashby', 'https://character.ai/careers', '{"slug":"character"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Character.AI');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Clay', 'ashby', 'https://www.clay.com/careers', '{"slug":"clay"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Clay');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MoneyLion', 'ashby', 'https://www.moneylion.com/careers/', '{"slug":"gen-digital"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MoneyLion');

-- -------------------------------------------------------
-- SMARTRECRUITERS (new companies)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Freshworks', 'smartrecruiters', 'https://www.freshworks.com/company/careers/', '{"slug":"freshworks"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Freshworks');

-- -------------------------------------------------------
-- EIGHTFOLD (new companies — confirmed domains)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PayPal', 'eightfold', 'https://paypal.eightfold.ai/careers/job-search-results', '{"domain":"paypal.com","careers_url":"https://paypal.eightfold.ai/careers/job-search-results"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PayPal');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Mercado Libre', 'eightfold', 'https://mercadolibre.eightfold.ai/careers', '{"domain":"mercadolibre.com","careers_url":"https://mercadolibre.eightfold.ai/careers"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Mercado Libre');

-- -------------------------------------------------------
-- PINPOINT (new companies — confirmed slugs)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'YNAB', 'pinpoint', 'https://ynab.pinpointhq.com', '{"slug":"ynab"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'YNAB');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Brivo', 'pinpoint', 'https://brivo.pinpointhq.com', '{"slug":"brivo"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Brivo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Confluence', 'pinpoint', 'https://confluence.pinpointhq.com', '{"slug":"confluence"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Confluence');
