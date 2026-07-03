-- Second-pass activation: Workday tenants found via slug variants
-- Each verified by checking the employer name on a live job posting

UPDATE companies SET active = true, ats_config = '{"tenant": "coke", "instance": "wd1", "site": "coca-cola-careers"}'::jsonb WHERE company_name = 'Coca-Cola' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "db", "instance": "wd3", "site": "DBWebsite"}'::jsonb WHERE company_name = 'Deutsche Bank' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "dukeenergy", "instance": "wd1", "site": "Search"}'::jsonb WHERE company_name = 'Duke Energy' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "geaerospace", "instance": "wd5", "site": "GE_ExternalSite"}'::jsonb WHERE company_name = 'GE Aerospace' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "gdit", "instance": "wd5", "site": "External_Career_Site"}'::jsonb WHERE company_name = 'General Dynamics' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "monolithicpower", "instance": "wd12", "site": "MPS_Careers"}'::jsonb WHERE company_name = 'Monolithic Power' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "ms", "instance": "wd5", "site": "External"}'::jsonb WHERE company_name = 'Morgan Stanley' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "ngc", "instance": "wd1", "site": "Northrop_Grumman_External_Site"}'::jsonb WHERE company_name = 'Northrop Grumman' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "republic", "instance": "wd5", "site": "Republic"}'::jsonb WHERE company_name = 'Republic Services' AND ats = 'workday';
