-- ============================================================
-- BATCH 7: User-confirmed ATS + newly found slugs
-- Run in Supabase SQL editor
-- ============================================================

-- -------------------------------------------------------
-- RIPPLING (new scraper)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kajabi', 'rippling', 'https://ats.rippling.com/kajabi/jobs', '{"slug":"kajabi"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kajabi');

-- -------------------------------------------------------
-- LEVER
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Match Group', 'lever', 'https://jobs.lever.co/matchgroup/', '{"slug":"matchgroup"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Match Group');

-- -------------------------------------------------------
-- GREENHOUSE (user-confirmed + slugs now found)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Altruist', 'greenhouse', 'https://altruist.com/join-altruist/', '{"slug":"altruist"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Altruist');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Noom', 'greenhouse', 'https://www.noom.com/careers/job-listings/', '{"slug":"noomgrowth"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Noom');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Gladly', 'greenhouse', 'https://www.gladly.ai/careers/', '{"slug":"sagansystems"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Gladly');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Payhawk', 'greenhouse', 'https://payhawk.com/en-us/careers', '{"slug":"payhawkio"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Payhawk');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Pipe', 'greenhouse', 'https://pipe.com/careers', '{"slug":"pipetechnologies"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Pipe');

-- SentinelOne, Wonderlic, Hinge — Greenhouse confirmed but slug not yet found
-- Add as inactive until slug is identified
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'SentinelOne', 'greenhouse', 'https://www.sentinelone.com/jobs/', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'SentinelOne');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Wonderlic', 'greenhouse', 'https://wonderlic.com/jobs/', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Wonderlic');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hinge', 'greenhouse', 'https://hinge.co/careers', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hinge');
