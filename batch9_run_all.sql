-- ============================================================
-- BATCH 9 (FINAL): Large-cap / Fortune-500 companies
-- ============================================================

-- -------------------------------------------------------
-- WORKDAY — ACTIVE (tenant confirmed by network interception)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AT&T', 'workday', 'https://www.att.jobs', '{"tenant":"att","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AT&T');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Abbott', 'workday', 'https://www.jobs.abbott', '{"tenant":"abbott","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Abbott');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Accenture', 'workday', 'https://www.accenture.com/us-en/careers', '{"tenant":"accenture","instance":"wd103"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Accenture');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Adobe', 'workday', 'https://careers.adobe.com', '{"tenant":"adobe","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Adobe');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Air Products', 'workday', 'https://www.airproducts.com/company/careers', '{"tenant":"airproducts","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Air Products');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Alcon', 'workday', 'https://www.alcon.com/careers', '{"tenant":"alcon","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Alcon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ameren', 'workday', 'https://ameren.com/careers', '{"tenant":"ameren","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ameren');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'American Electric Power', 'workday', 'https://aep.com/careers', '{"tenant":"aep","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'American Electric Power');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Amgen', 'workday', 'https://careers.amgen.com', '{"tenant":"amgen","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Amgen');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Analog Devices', 'workday', 'https://www.analog.com/en/about-adi/careers.html', '{"tenant":"analogdevices","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Analog Devices');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Apollo Global Mgmt', 'workday', 'https://www.apollo.com/careers', '{"tenant":"athene","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Apollo Global Mgmt');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Arch Capital', 'workday', 'https://www.archcapgroup.com/careers', '{"tenant":"archgroup","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Arch Capital');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ares Management', 'workday', 'https://www.aresmgmt.com/careers', '{"tenant":"aresmgmt","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ares Management');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Baker Hughes', 'workday', 'https://careers.bakerhughes.com', '{"tenant":"bakerhughes","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Baker Hughes');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bank of America', 'workday', 'https://careers.bankofamerica.com', '{"tenant":"ghr","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bank of America');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bank of Montreal', 'workday', 'https://jobs.bmo.com', '{"tenant":"bmo","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bank of Montreal');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Barclays', 'workday', 'https://search.jobs.barclays', '{"tenant":"barclays","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Barclays');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BeOne Medicines', 'workday', 'https://beonemedicines.com/careers/', '{"tenant":"beigene","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BeOne Medicines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Becton Dickinson', 'workday', 'https://jobs.bd.com', '{"tenant":"bdx","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Becton Dickinson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Biogen', 'workday', 'https://www.biogen.com/careers', '{"tenant":"biibhr","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Biogen');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Blackstone', 'workday', 'https://www.blackstone.com/careers/', '{"tenant":"blackstone","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Blackstone');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bloom Energy', 'workday', 'https://www.bloomenergy.com/careers', '{"tenant":"bloomenergy","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bloom Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bristol-Myers Squibb', 'workday', 'https://careers.bms.com', '{"tenant":"bristolmyerssquibb","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bristol-Myers Squibb');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Brookfield Asset Mgmt', 'workday', 'https://www.brookfield.com/careers', '{"tenant":"brookfield","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Brookfield Asset Mgmt');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Brookfield Corp', 'workday', 'https://www.brookfield.com/careers', '{"tenant":"brookfield","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Brookfield Corp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cadence Design', 'workday', 'https://www.cadence.com/en_US/home/company/careers.html', '{"tenant":"cadence","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cadence Design');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Capital One', 'workday', 'https://www.capitalonecareers.com', '{"tenant":"capitalone","instance":"wd12"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Capital One');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Centene', 'workday', 'https://jobs.centene.com', '{"tenant":"centene","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Centene');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ciena', 'workday', 'https://careers.ciena.com', '{"tenant":"ciena","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ciena');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cigna', 'workday', 'https://jobs.cigna.com', '{"tenant":"cigna","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cigna');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Comcast', 'workday', 'https://jobs.comcast.com', '{"tenant":"comcast","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Comcast');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Comfort Systems USA', 'workday', 'https://www.comfortsystemsusa.com/careers', '{"tenant":"comfortsystemsusa","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Comfort Systems USA');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ConocoPhillips', 'workday', 'https://careers.conocophillips.com', '{"tenant":"conocophillips","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ConocoPhillips');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CrowdStrike', 'workday', 'https://www.crowdstrike.com/en-us/careers/', '{"tenant":"crowdstrike","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CrowdStrike');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Curtiss-Wright', 'workday', 'https://www.curtisswright.com/careers', '{"tenant":"curtisswright","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Curtiss-Wright');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Danaher', 'workday', 'https://jobs.danaher.com', '{"tenant":"danaher","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Danaher');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Diageo', 'workday', 'https://www.diageo.com/en/careers', '{"tenant":"diageo","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Diageo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ecolab', 'workday', 'https://careers.ecolab.com', '{"tenant":"ecolab","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ecolab');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Elevance Health', 'workday', 'https://www.elevancehealth.com/careers', '{"tenant":"elevancehealth","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Elevance Health');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Eli Lilly', 'workday', 'https://careers.lilly.com', '{"tenant":"lilly","instance":"wd115"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Eli Lilly');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Equinix', 'workday', 'https://careers.equinix.com', '{"tenant":"equinix","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Equinix');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Equinor', 'workday', 'https://www.equinor.com/careers', '{"tenant":"equinor","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Equinor');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fair Isaac (FICO)', 'workday', 'https://www.fico.com/en/careers', '{"tenant":"fico","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fair Isaac (FICO)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GE HealthCare', 'workday', 'https://careers.gehealthcare.com', '{"tenant":"gehc","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GE HealthCare');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Gilead Sciences', 'workday', 'https://www.gilead.com/careers', '{"tenant":"gilead","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Gilead Sciences');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hewlett Packard Ent', 'workday', 'https://careers.hpe.com', '{"tenant":"hpe","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hewlett Packard Ent');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Humana', 'workday', 'https://careers.humana.com', '{"tenant":"humana","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Humana');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Huntington Bancshares', 'workday', 'https://www.huntington.com/Careers', '{"tenant":"huntington","instance":"wd12"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Huntington Bancshares');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'IDEXX Labs', 'workday', 'https://idexx.com/careers', '{"tenant":"idexx","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'IDEXX Labs');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'IQVIA', 'workday', 'https://jobs.iqvia.com', '{"tenant":"iqvia","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'IQVIA');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Intel', 'workday', 'https://jobs.intel.com', '{"tenant":"intel","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Intel');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Jabil', 'workday', 'https://jabil.com/careers', '{"tenant":"jabil","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Jabil');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Johnson & Johnson', 'workday', 'https://jobs.jnj.com', '{"tenant":"jj","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Johnson & Johnson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Johnson Controls', 'workday', 'https://jobs.johnsoncontrols.com', '{"tenant":"jci","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Johnson Controls');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'KLA', 'workday', 'https://www.kla.com/careers', '{"tenant":"kla","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'KLA');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Live Nation', 'workday', 'https://www.livenationentertainment.com/careers', '{"tenant":"livenation","instance":"wd503"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Live Nation');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lloyds Banking', 'workday', 'https://www.lloydsbankinggroup.com/careers.html', '{"tenant":"lbg","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lloyds Banking');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lumentum', 'workday', 'https://www.lumentum.com/en/careers', '{"tenant":"lumentum","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lumentum');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Marvell', 'workday', 'https://www.marvell.com/company/careers/', '{"tenant":"marvell","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Marvell');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Mastercard', 'workday', 'https://careers.mastercard.com', '{"tenant":"mastercard","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Mastercard');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Merck', 'workday', 'https://jobs.merck.com', '{"tenant":"msd","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Merck');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Micron', 'workday', 'https://www.micron.com/careers', '{"tenant":"micron","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Micron');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Motorola Solutions', 'workday', 'https://motorolasolutions.com/careers', '{"tenant":"motorolasolutions","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Motorola Solutions');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nike', 'workday', 'https://nike.wd1.myworkdayjobs.com/nke/', '{"tenant":"nike","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nike');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Northern Trust', 'workday', 'https://careers.northerntrust.com', '{"tenant":"ntrs","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Northern Trust');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Novartis', 'workday', 'https://www.novartis.com/careers', '{"tenant":"novartis","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Novartis');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'O''Reilly Automotive', 'workday', 'https://careers.oreillyauto.com', '{"tenant":"oreillyauto","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'O''Reilly Automotive');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ONEOK', 'workday', 'https://www.oneok.com/careers', '{"tenant":"oneok","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ONEOK');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Occidental Petroleum', 'workday', 'https://www.oxy.com/careers', '{"tenant":"oxy","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Occidental Petroleum');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Old Dominion Freight', 'workday', 'https://www.odfl.com/us/en/about-od/careers.html', '{"tenant":"odfl","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Old Dominion Freight');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Procter & Gamble', 'workday', 'https://www.pgcareers.com/us/en', '{"tenant":"pg","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Procter & Gamble');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Prudential Financial', 'workday', 'https://jobs.prudential.com', '{"tenant":"pru","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Prudential Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Qnity Electronics', 'workday', 'https://careers.qnityelectronics.com', '{"tenant":"qnity","instance":"wd503"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Qnity Electronics');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'RTX', 'workday', 'https://careers.rtx.com', '{"tenant":"globalhr","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'RTX');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Realty Income', 'workday', 'https://www.realtyincome.com/careers', '{"tenant":"realtyincome","instance":"wd108"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Realty Income');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Restaurant Brands Intl', 'workday', 'https://careers.rbi.com', '{"tenant":"rbi","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Restaurant Brands Intl');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Royal Bank of Canada', 'workday', 'https://jobs.rbc.com', '{"tenant":"rbc","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Royal Bank of Canada');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'S&P Global', 'workday', 'https://careers.spglobal.com', '{"tenant":"spgi","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'S&P Global');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Shell', 'workday', 'https://www.shell.com/careers', '{"tenant":"shell","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Shell');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'State Street', 'workday', 'https://careers.statestreet.com', '{"tenant":"statestreet","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'State Street');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Stryker', 'workday', 'https://careers.stryker.com', '{"tenant":"stryker","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Stryker');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sunbelt Rentals', 'workday', 'https://careers.sunbeltrentals.com', '{"tenant":"sunbeltrentals","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sunbelt Rentals');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'T-Mobile', 'workday', 'https://careers.t-mobile.com', '{"tenant":"tmobile","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'T-Mobile');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Tapestry', 'workday', 'https://careers.tapestry.com', '{"tenant":"tapestry","instance":"wd108"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Tapestry');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Target', 'workday', 'https://corporate.target.com/careers', '{"tenant":"target","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Target');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Teledyne', 'workday', 'https://www.teledyne.com/en-us/careers', '{"tenant":"flir","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Teledyne');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Thomson Reuters', 'workday', 'https://careers.thomsonreuters.com', '{"tenant":"thomsonreuters","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Thomson Reuters');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Toronto-Dominion', 'workday', 'https://jobs.td.com', '{"tenant":"td","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Toronto-Dominion');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Trane Technologies', 'workday', 'https://careers.tranetechnologies.com', '{"tenant":"tranetechnologies","instance":"wd12"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Trane Technologies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Travelers', 'workday', 'https://careers.travelers.com', '{"tenant":"travelers","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Travelers');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Truist Financial', 'workday', 'https://careers.truist.com', '{"tenant":"truist","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Truist Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'U.S. Bancorp', 'workday', 'https://careers.usbank.com', '{"tenant":"usbank","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'U.S. Bancorp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Unilever', 'workday', 'https://careers.unilever.com', '{"tenant":"unilever","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Unilever');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ventas', 'workday', 'https://www.ventasreit.com/careers', '{"tenant":"ventas","instance":"wd503"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ventas');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Verizon', 'workday', 'https://mycareer.verizon.com', '{"tenant":"verizon","instance":"wd12"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Verizon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Warner Bros Discovery', 'workday', 'https://careers.wbd.com', '{"tenant":"warnerbros","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Warner Bros Discovery');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Workday', 'workday', 'https://www.workday.com/en-us/company/careers.html', '{"tenant":"workday","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Workday');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Xcel Energy', 'workday', 'https://www.xcelenergy.com/careers', '{"tenant":"xcelenergy","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Xcel Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Zoetis', 'workday', 'https://careers.zoetis.com', '{"tenant":"zoetis","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Zoetis');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'argenx', 'workday', 'https://www.argenx.com/careers', '{"tenant":"argenx","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'argenx');

-- -------------------------------------------------------
-- WORKDAY — ACTIVE (tenant confirmed by API probe)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Dell', 'workday', 'https://jobs.dell.com', '{"tenant":"dell","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Dell');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GLOBALFOUNDRIES', 'workday', 'https://gf.com/careers', '{"tenant":"globalfoundries","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GLOBALFOUNDRIES');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Illinois Tool Works', 'workday', 'https://careers.itw.com', '{"tenant":"itw","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Illinois Tool Works');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PNC Financial', 'workday', 'https://www.pnc.com/en/about-pnc/careers.html', '{"tenant":"pnc","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PNC Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Qualcomm', 'workday', 'https://careers.qualcomm.com', '{"tenant":"qualcomm","instance":"wd12"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Qualcomm');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Takeda', 'workday', 'https://www.takeda.com/en-us/careers', '{"tenant":"takeda","instance":"wd3"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Takeda');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Walmart', 'workday', 'https://careers.walmart.com', '{"tenant":"walmart","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Walmart');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Williams Companies', 'workday', 'https://careers.williams.com', '{"tenant":"williams","instance":"wd5"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Williams Companies');

-- -------------------------------------------------------
-- WORKDAY — INACTIVE (slug guessed, instance defaulted to wd1)
-- Verify: update ats_config and set active=true when confirmed
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT '3M', 'workday', 'https://www.3m.com/3M/en_US/careers-us/', '{"tenant":"3m","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = '3M');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AbbVie', 'workday', 'https://careers.abbvie.com', '{"tenant":"abbvie","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AbbVie');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Aflac', 'workday', 'https://careers.aflac.com', '{"tenant":"aflac","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Aflac');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Agilent', 'workday', 'https://jobs.agilent.com', '{"tenant":"agilent","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Agilent');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Agnico Eagle Mines', 'workday', 'https://agnicoeagle.com/careers', '{"tenant":"agnicoeagle","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Agnico Eagle Mines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AIG', 'workday', 'https://careers.aig.com', '{"tenant":"aig","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AIG');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Allstate', 'workday', 'https://careers.allstate.com', '{"tenant":"allstate","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Allstate');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Alnylam Pharma', 'workday', 'https://www.alnylam.com/careers', '{"tenant":"alnylam","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Alnylam Pharma');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Altria', 'workday', 'https://careers.altria.com', '{"tenant":"altria","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Altria');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ambev', 'workday', 'https://www.ambev.com.br/carreiras/', '{"tenant":"ambev","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ambev');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AMD', 'workday', 'https://careers.amd.com', '{"tenant":"amd","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AMD');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'American Express', 'workday', 'https://careers.americanexpress.com', '{"tenant":"americanexpress","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'American Express');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'American Tower', 'workday', 'https://careers.americantower.com', '{"tenant":"americantower","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'American Tower');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ameriprise Financial', 'workday', 'https://www.ameriprise.com/careers', '{"tenant":"ameriprise","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ameriprise Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AMETEK', 'workday', 'https://www.ametek.com/careers', '{"tenant":"ametek","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AMETEK');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Amphenol', 'workday', 'https://careers.amphenol.com', '{"tenant":"amphenol","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Amphenol');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AngloGold Ashanti', 'workday', 'https://www.anglogoldashanti.com/careers', '{"tenant":"anglogoldashanti","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AngloGold Ashanti');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Anheuser-Busch InBev', 'workday', 'https://careers.ab-inbev.com', '{"tenant":"abinbev","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Anheuser-Busch InBev');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Aon', 'workday', 'https://careers.aon.com', '{"tenant":"aon","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Aon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Applied Materials', 'workday', 'https://careers.appliedmaterials.com', '{"tenant":"appliedmaterials","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Applied Materials');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ArcelorMittal', 'workday', 'https://careers.arcelormittal.com', '{"tenant":"arcelormittal","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ArcelorMittal');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Archer-Daniels-Midland', 'workday', 'https://careers.adm.com', '{"tenant":"adm","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Archer-Daniels-Midland');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Arista Networks', 'workday', 'https://www.arista.com/en/careers', '{"tenant":"arista","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Arista Networks');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Arm Holdings', 'workday', 'https://careers.arm.com', '{"tenant":"arm","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Arm Holdings');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Arthur J. Gallagher', 'workday', 'https://careers.ajg.com', '{"tenant":"ajg","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Arthur J. Gallagher');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ASML', 'workday', 'https://www.asml.com/en/careers', '{"tenant":"asml","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ASML');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AstraZeneca', 'workday', 'https://careers.astrazeneca.com', '{"tenant":"astrazeneca","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AstraZeneca');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Atmos Energy', 'workday', 'https://careers.atmosenergy.com', '{"tenant":"atmosenergy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Atmos Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Autodesk', 'workday', 'https://www.autodesk.com/careers', '{"tenant":"autodesk","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Autodesk');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AutoZone', 'workday', 'https://careers.autozone.com', '{"tenant":"autozone","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AutoZone');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bank of Nova Scotia', 'workday', 'https://jobs.scotiabank.com', '{"tenant":"scotiabank","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bank of Nova Scotia');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Barrick Mining', 'workday', 'https://www.barrick.com/careers', '{"tenant":"barrick","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Barrick Mining');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BHP Group', 'workday', 'https://www.bhp.com/careers', '{"tenant":"bhp","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BHP Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BlackRock', 'workday', 'https://careers.blackrock.com', '{"tenant":"blackrock","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BlackRock');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BNY Mellon', 'workday', 'https://bny.com/careers', '{"tenant":"bnymellon","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BNY Mellon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Booking Holdings', 'workday', 'https://careers.bookingholdings.com', '{"tenant":"bookingholdings","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Booking Holdings');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Boston Scientific', 'workday', 'https://jobs.bostonscientific.com', '{"tenant":"bostonscientific","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Boston Scientific');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BP', 'workday', 'https://www.bp.com/careers', '{"tenant":"bp","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BP');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'British American Tobacco', 'workday', 'https://www.bat.com/careers', '{"tenant":"bat","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'British American Tobacco');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Broadcom', 'workday', 'https://careers.broadcom.com', '{"tenant":"broadcom","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Broadcom');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cameco', 'workday', 'https://www.cameco.com/careers', '{"tenant":"cameco","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cameco');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Canadian National Rail', 'workday', 'https://www.cn.ca/en/careers/', '{"tenant":"cn","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Canadian National Rail');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Canadian Natural Res', 'workday', 'https://www.cnrl.com/careers', '{"tenant":"cnrl","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Canadian Natural Res');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Canadian Pacific KC', 'workday', 'https://careers.cpkcr.com', '{"tenant":"cpkc","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Canadian Pacific KC');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cardinal Health', 'workday', 'https://jobs.cardinalhealth.com', '{"tenant":"cardinalhealth","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cardinal Health');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Carnival', 'workday', 'https://jobs.carnival.com', '{"tenant":"carnival","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Carnival');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Carrier Global', 'workday', 'https://careers.carrier.com', '{"tenant":"carrier","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Carrier Global');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Casey''s General Stores', 'workday', 'https://careers.caseys.com', '{"tenant":"caseys","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Casey''s General Stores');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Caterpillar', 'workday', 'https://careers.caterpillar.com', '{"tenant":"caterpillar","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Caterpillar');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cboe Global Markets', 'workday', 'https://careers.cboe.com', '{"tenant":"cboe","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cboe Global Markets');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CBRE Group', 'workday', 'https://careers.cbre.com', '{"tenant":"cbre","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CBRE Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Celestica', 'workday', 'https://www.celestica.com/careers', '{"tenant":"celestica","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Celestica');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cencora', 'workday', 'https://careers.cencora.com', '{"tenant":"cencora","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cencora');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cenovus Energy', 'workday', 'https://careers.cenovus.com', '{"tenant":"cenovus","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cenovus Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CenterPoint Energy', 'workday', 'https://jobs.centerpointenergy.com', '{"tenant":"centerpointenergy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CenterPoint Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Charles Schwab', 'workday', 'https://www.schwab.com/careers', '{"tenant":"schwab","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Charles Schwab');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cheniere Energy', 'workday', 'https://careers.cheniere.com', '{"tenant":"cheniere","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cheniere Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cheniere Energy Partners', 'workday', 'https://careers.cheniere.com', '{"tenant":"cheniere","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cheniere Energy Partners');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Chevron', 'workday', 'https://www.chevron.com/careers', '{"tenant":"chevron","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Chevron');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Chipotle', 'workday', 'https://jobs.chipotle.com', '{"tenant":"chipotle","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Chipotle');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Chubb', 'workday', 'https://careers.chubb.com', '{"tenant":"chubb","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Chubb');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CIBC', 'workday', 'https://www.cibc.com/en/about-cibc/careers.html', '{"tenant":"cibc","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CIBC');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cintas', 'workday', 'https://careers.cintas.com', '{"tenant":"cintas","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cintas');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cisco', 'workday', 'https://jobs.cisco.com', '{"tenant":"cisco","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cisco');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Citigroup', 'workday', 'https://careers.citi.com', '{"tenant":"citi","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Citigroup');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CME Group', 'workday', 'https://careers.cmegroup.com', '{"tenant":"cmegroup","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CME Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coca-Cola', 'workday', 'https://careers.coca-colacompany.com', '{"tenant":"cocacola","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coca-Cola');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coca-Cola Europacific', 'workday', 'https://careers.ccep.com', '{"tenant":"ccep","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coca-Cola Europacific');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coherent', 'workday', 'https://careers.coherent.com', '{"tenant":"coherent","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coherent');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Colgate-Palmolive', 'workday', 'https://jobs.colgate.com', '{"tenant":"colgate","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Colgate-Palmolive');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Consolidated Edison', 'workday', 'https://careers.coned.com', '{"tenant":"coned","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Consolidated Edison');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Constellation Energy', 'workday', 'https://careers.constellationenergy.com', '{"tenant":"constellationenergy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Constellation Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Copart', 'workday', 'https://www.copart.com/content/us/en/careers', '{"tenant":"copart","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Copart');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Corning', 'workday', 'https://www.corning.com/worldwide/en/careers.html', '{"tenant":"corning","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Corning');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Corteva', 'workday', 'https://careers.corteva.com', '{"tenant":"corteva","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Corteva');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CRH', 'workday', 'https://www.crh.com/careers', '{"tenant":"crh","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CRH');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Crown Castle', 'workday', 'https://careers.crowncastle.com', '{"tenant":"crowncastle","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Crown Castle');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CSX', 'workday', 'https://jobs.csx.com', '{"tenant":"csx","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CSX');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cummins', 'workday', 'https://careers.cummins.com', '{"tenant":"cummins","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cummins');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'D.R. Horton', 'workday', 'https://careers.drhorton.com', '{"tenant":"drhorton","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'D.R. Horton');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Deere', 'workday', 'https://jobs.deere.com', '{"tenant":"deere","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Deere');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Delta Air Lines', 'workday', 'https://www.deltaairlines.com/careers', '{"tenant":"delta","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Delta Air Lines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Deutsche Bank', 'workday', 'https://careers.db.com', '{"tenant":"deutschebank","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Deutsche Bank');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Devon Energy', 'workday', 'https://www.devonenergy.com/careers', '{"tenant":"devon","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Devon Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'DexCom', 'workday', 'https://careers.dexcom.com', '{"tenant":"dexcom","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'DexCom');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Diamondback Energy', 'workday', 'https://careers.diamondbackenergy.com', '{"tenant":"diamondbackenergy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Diamondback Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Digital Realty', 'workday', 'https://careers.digitalrealty.com', '{"tenant":"digitalrealty","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Digital Realty');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Dominion Energy', 'workday', 'https://careers.dominionenergy.com', '{"tenant":"dominionenergy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Dominion Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Dover', 'workday', 'https://www.dovercorporation.com/careers', '{"tenant":"dovercrp","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Dover');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'DTE Energy', 'workday', 'https://careers.dteenergy.com', '{"tenant":"dte","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'DTE Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Duke Energy', 'workday', 'https://careers.duke-energy.com', '{"tenant":"duke","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Duke Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Eaton', 'workday', 'https://careers.eaton.com', '{"tenant":"eaton","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Eaton');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'eBay', 'workday', 'https://careers.ebayinc.com', '{"tenant":"ebay","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'eBay');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EchoStar', 'workday', 'https://careers.echostar.com', '{"tenant":"echostar","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EchoStar');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Edison International', 'workday', 'https://www.edisoninternational.com/careers', '{"tenant":"edisonintl","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Edison International');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Edwards Lifesciences', 'workday', 'https://careers.edwards.com', '{"tenant":"edwards","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Edwards Lifesciences');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Electronic Arts', 'workday', 'https://jobs.ea.com', '{"tenant":"ea","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Electronic Arts');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EMCOR Group', 'workday', 'https://emcor.com/careers', '{"tenant":"emcor","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EMCOR Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Emerson Electric', 'workday', 'https://www.emerson.com/en-us/careers', '{"tenant":"emerson","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Emerson Electric');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Enbridge', 'workday', 'https://www.enbridge.com/careers', '{"tenant":"enbridge","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Enbridge');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Energy Transfer', 'workday', 'https://www.energytransfer.com/careers', '{"tenant":"energytransfer","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Energy Transfer');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Entergy', 'workday', 'https://jobs.entergy.com', '{"tenant":"entergy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Entergy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Enterprise Products', 'workday', 'https://www.enterpriseproducts.com/careers', '{"tenant":"enterpriseproducts","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Enterprise Products');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EOG Resources', 'workday', 'https://careers.eogresources.com', '{"tenant":"eog","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EOG Resources');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EQT Corp', 'workday', 'https://careers.eqt.com', '{"tenant":"eqt","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EQT Corp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ericsson', 'workday', 'https://www.ericsson.com/en/careers', '{"tenant":"ericsson","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ericsson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Estee Lauder', 'workday', 'https://careers.elcompanies.com', '{"tenant":"elcompanies","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Estee Lauder');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Exelon', 'workday', 'https://careers.exeloncorp.com', '{"tenant":"exelon","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Exelon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Extra Space Storage', 'workday', 'https://careers.extraspace.com', '{"tenant":"extraspace","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Extra Space Storage');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fastenal', 'workday', 'https://careers.fastenal.com', '{"tenant":"fastenal","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fastenal');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'FedEx', 'workday', 'https://careers.fedex.com', '{"tenant":"fedex","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'FedEx');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ferguson', 'workday', 'https://careers.ferguson.com', '{"tenant":"ferguson","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ferguson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fifth Third Bancorp', 'workday', 'https://www.53.com/content/fifth-third/en/careers.html', '{"tenant":"fifththird","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fifth Third Bancorp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'First Solar', 'workday', 'https://jobs.firstsolar.com', '{"tenant":"firstsolar","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'First Solar');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fiserv', 'workday', 'https://careers.fiserv.com', '{"tenant":"fiserv","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fiserv');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Flex', 'workday', 'https://careers.flex.com', '{"tenant":"flex","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Flex');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ford Motor', 'workday', 'https://careers.ford.com', '{"tenant":"ford","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ford Motor');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fortinet', 'workday', 'https://www.fortinet.com/corporate/careers', '{"tenant":"fortinet","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fortinet');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fortis', 'workday', 'https://careers.fortisinc.com', '{"tenant":"fortis","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fortis');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Franco-Nevada', 'workday', 'https://www.franco-nevada.com/careers', '{"tenant":"franconevada","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Franco-Nevada');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Freeport-McMoRan', 'workday', 'https://careers.fcx.com', '{"tenant":"fcx","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Freeport-McMoRan');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Garmin', 'workday', 'https://careers.garmin.com', '{"tenant":"garmin","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Garmin');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GE Aerospace', 'workday', 'https://jobs.gecareers.com', '{"tenant":"ge","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GE Aerospace');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GE Vernova', 'workday', 'https://jobs.gecareers.com/vernova', '{"tenant":"gevernova","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GE Vernova');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'General Dynamics', 'workday', 'https://www.gd.com/careers', '{"tenant":"gd","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'General Dynamics');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'General Motors', 'workday', 'https://careers.gm.com', '{"tenant":"generalmotors","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'General Motors');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Gold Fields', 'workday', 'https://careers.goldfields.com', '{"tenant":"goldfields","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Gold Fields');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Goldman Sachs', 'workday', 'https://www.goldmansachs.com/careers', '{"tenant":"goldmansachs","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Goldman Sachs');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GSK', 'workday', 'https://careers.gsk.com', '{"tenant":"gsk","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GSK');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Haleon', 'workday', 'https://www.haleon.com/careers', '{"tenant":"haleon","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Haleon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Halliburton', 'workday', 'https://www.halliburton.com/en/careers', '{"tenant":"halliburton","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Halliburton');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hartford Insurance', 'workday', 'https://www.thehartford.com/careers', '{"tenant":"thehartford","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hartford Insurance');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'HCA Healthcare', 'workday', 'https://careers.hcahealthcare.com', '{"tenant":"hca","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'HCA Healthcare');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'HEICO', 'workday', 'https://www.heico.com/careers', '{"tenant":"heico","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'HEICO');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hershey', 'workday', 'https://careers.thehersheycompany.com', '{"tenant":"hershey","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hershey');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hilton', 'workday', 'https://jobs.hilton.com', '{"tenant":"hilton","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hilton');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Honeywell', 'workday', 'https://careers.honeywell.com', '{"tenant":"honeywell","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Honeywell');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Howmet Aerospace', 'workday', 'https://careers.howmet.com', '{"tenant":"howmet","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Howmet Aerospace');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'HSBC', 'workday', 'https://www.hsbc.com/careers', '{"tenant":"hsbc","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'HSBC');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'IBM', 'workday', 'https://www.ibm.com/careers', '{"tenant":"ibm","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'IBM');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Imperial Oil', 'workday', 'https://www.imperialoil.ca/en-CA/company/careers', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Imperial Oil');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ING Groep', 'workday', 'https://www.ing.jobs', '{"tenant":"ing","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ING Groep');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ingersoll Rand', 'workday', 'https://careers.irco.com', '{"tenant":"ingersollrand","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ingersoll Rand');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Interactive Brokers', 'workday', 'https://www.interactivebrokers.com/en/general/about/jobs.php', '{"tenant":"ibkr","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Interactive Brokers');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Intercontinental Exch', 'workday', 'https://careers.intercontinentalexchange.com', '{"tenant":"ice","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Intercontinental Exch');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Intuit', 'workday', 'https://careers.intuit.com', '{"tenant":"intuit","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Intuit');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Intuitive Surgical', 'workday', 'https://careers.intuitive.com', '{"tenant":"intuitive","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Intuitive Surgical');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Iron Mountain', 'workday', 'https://careers.ironmountain.com', '{"tenant":"ironmountain","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Iron Mountain');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'JPMorgan Chase', 'workday', 'https://careers.jpmorgan.com', '{"tenant":"jpmorgan","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'JPMorgan Chase');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kenvue', 'workday', 'https://careers.kenvue.com', '{"tenant":"kenvue","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kenvue');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Keurig Dr Pepper', 'workday', 'https://careers.keurigdrpepper.com', '{"tenant":"keurigdrpepper","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Keurig Dr Pepper');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Keysight', 'workday', 'https://jobs.keysight.com', '{"tenant":"keysight","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Keysight');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kimberly-Clark', 'workday', 'https://jobs.kimberly-clark.com', '{"tenant":"kimberlyclark","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kimberly-Clark');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kinder Morgan', 'workday', 'https://www.kindermorgan.com/Careers/', '{"tenant":"kindermorgan","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kinder Morgan');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kinross Gold', 'workday', 'https://careers.kinross.com', '{"tenant":"kinross","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kinross Gold');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'KKR', 'workday', 'https://www.kkr.com/careers', '{"tenant":"kkr","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'KKR');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kroger', 'workday', 'https://jobs.kroger.com', '{"tenant":"kroger","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kroger');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'L3Harris', 'workday', 'https://careers.l3harris.com', '{"tenant":"l3harris","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'L3Harris');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lam Research', 'workday', 'https://careers.lamresearch.com', '{"tenant":"lamresearch","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lam Research');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Las Vegas Sands', 'workday', 'https://jobs.lasvegassands.com', '{"tenant":"sands","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Las Vegas Sands');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Linde', 'workday', 'https://jobs.linde.com', '{"tenant":"linde","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Linde');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lockheed Martin', 'workday', 'https://www.lockheedmartinjobs.com', '{"tenant":"lmco","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lockheed Martin');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lowe''s', 'workday', 'https://careers.lowes.com', '{"tenant":"lowes","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lowe''s');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'M&T Bank', 'workday', 'https://careers.mtb.com', '{"tenant":"mtb","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'M&T Bank');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MACOM Technology', 'workday', 'https://www.macom.com/careers', '{"tenant":"macom","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MACOM Technology');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Manulife Financial', 'workday', 'https://jobs.manulife.com', '{"tenant":"manulife","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Manulife Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Marathon Petroleum', 'workday', 'https://careers.marathonpetroleum.com', '{"tenant":"mpc","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Marathon Petroleum');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Marriott', 'workday', 'https://careers.marriott.com', '{"tenant":"marriott","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Marriott');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Marsh & McLennan', 'workday', 'https://careers.mmc.com', '{"tenant":"mmc","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Marsh & McLennan');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Martin Marietta', 'workday', 'https://careers.martinmarietta.com', '{"tenant":"martinmarietta","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Martin Marietta');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MasTec', 'workday', 'https://mastec.com/careers', '{"tenant":"mastec","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MasTec');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'McDonald''s', 'workday', 'https://careers.mcdonalds.com', '{"tenant":"mcdonalds","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'McDonald''s');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'McKesson', 'workday', 'https://careers.mckesson.com', '{"tenant":"mckesson","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'McKesson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Medline', 'workday', 'https://medline.com/careers', '{"tenant":"medline","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Medline');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Medtronic', 'workday', 'https://jobs.medtronic.com', '{"tenant":"medtronic","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Medtronic');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MetLife', 'workday', 'https://jobs.metlife.com', '{"tenant":"metlife","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MetLife');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Microchip Technology', 'workday', 'https://careers.microchip.com', '{"tenant":"microchip","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Microchip Technology');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Mondelez', 'workday', 'https://careers.mondelezinternational.com', '{"tenant":"mondelez","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Mondelez');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Monolithic Power', 'workday', 'https://www.monolithicpower.com/careers', '{"tenant":"mpssemi","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Monolithic Power');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Monster Beverage', 'workday', 'https://careers.monsterbevcorp.com', '{"tenant":"monsterbevcorp","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Monster Beverage');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Moody''s', 'workday', 'https://careers.moodys.com', '{"tenant":"moodys","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Moody''s');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Morgan Stanley', 'workday', 'https://www.morganstanley.com/careers', '{"tenant":"morganstanley","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Morgan Stanley');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MPLX', 'workday', 'https://careers.marathonpetroleum.com', '{"tenant":"mpc","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MPLX');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MSCI', 'workday', 'https://www.msci.com/careers', '{"tenant":"msci","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MSCI');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nasdaq', 'workday', 'https://nasdaq.com/careers', '{"tenant":"nasdaq","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nasdaq');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Natera', 'workday', 'https://natera.com/company/careers', '{"tenant":"natera","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Natera');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'National Grid', 'workday', 'https://careers.nationalgrid.com', '{"tenant":"nationalgrid","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'National Grid');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NatWest', 'workday', 'https://www.natwest.com/careers.html', '{"tenant":"natwest","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NatWest');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NetApp', 'workday', 'https://careers.netapp.com', '{"tenant":"netapp","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NetApp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Netflix', 'workday', 'https://jobs.netflix.com/', '{"tenant":"netflix","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Netflix');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Newmont', 'workday', 'https://newmont.com/careers', '{"tenant":"newmont","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Newmont');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NextEra Energy', 'workday', 'https://careers.nexteraenergy.com', '{"tenant":"nexteraenergy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NextEra Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nokia', 'workday', 'https://www.nokia.com/about-us/careers/', '{"tenant":"nokia","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nokia');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Norfolk Southern', 'workday', 'https://www.nscorp.com/content/nscorp/en/careers.html', '{"tenant":"nscorp","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Norfolk Southern');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Northrop Grumman', 'workday', 'https://www.northropgrumman.com/careers/', '{"tenant":"northropgrumman","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Northrop Grumman');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Novo Nordisk', 'workday', 'https://www.novonordisk.com/careers', '{"tenant":"novonordisk","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Novo Nordisk');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NRG Energy', 'workday', 'https://careers.nrgenergy.com', '{"tenant":"nrg","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NRG Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nucor', 'workday', 'https://careers.nucor.com', '{"tenant":"nucor","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nucor');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nutrien', 'workday', 'https://nutrien.com/careers', '{"tenant":"nutrien","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nutrien');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'nVent Electric', 'workday', 'https://careers.nvent.com', '{"tenant":"nvent","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'nVent Electric');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NVIDIA', 'workday', 'https://www.nvidia.com/en-us/about-nvidia/careers/', '{"tenant":"nvidia","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NVIDIA');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NXP Semiconductors', 'workday', 'https://careers.nxp.com', '{"tenant":"nxp","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NXP Semiconductors');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ON Semiconductor', 'workday', 'https://www.onsemi.com/careers', '{"tenant":"onsemi","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ON Semiconductor');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PACCAR', 'workday', 'https://careers.paccar.com', '{"tenant":"paccar","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PACCAR');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Palo Alto Networks', 'workday', 'https://careers.paloaltonetworks.com', '{"tenant":"paloaltonetworks","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Palo Alto Networks');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Parker-Hannifin', 'workday', 'https://careers.parker.com', '{"tenant":"parker","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Parker-Hannifin');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Paychex', 'workday', 'https://careers.paychex.com', '{"tenant":"paychex","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Paychex');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PayPal', 'workday', 'https://careers.pypl.com/', '{"tenant":"paypal","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PayPal');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Pembina Pipeline', 'workday', 'https://careers.pembina.com', '{"tenant":"pembina","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Pembina Pipeline');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PepsiCo', 'workday', 'https://www.pepsicojobs.com', '{"tenant":"pepsico","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PepsiCo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Pfizer', 'workday', 'https://www.pfizercareers.com', '{"tenant":"pfizer","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Pfizer');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PG&E', 'workday', 'https://careers.pge.com', '{"tenant":"pge","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PG&E');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Philip Morris Intl', 'workday', 'https://careers.pmi.com', '{"tenant":"pmi","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Philip Morris Intl');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Phillips 66', 'workday', 'https://careers.phillips66.com', '{"tenant":"phillips66","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Phillips 66');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Progressive', 'workday', 'https://www.progressive.com/careers/', '{"tenant":"progressive","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Progressive');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Prologis', 'workday', 'https://careers.prologis.com', '{"tenant":"prologis","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Prologis');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Public Service Enterprise', 'workday', 'https://jobs.pseg.com', '{"tenant":"pseg","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Public Service Enterprise');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Public Storage', 'workday', 'https://jobs.publicstorage.com', '{"tenant":"publicstorage","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Public Storage');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Quanta Services', 'workday', 'https://www.quantaservices.com/careers', '{"tenant":"quantaservices","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Quanta Services');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Raymond James', 'workday', 'https://jobs.raymondjames.com', '{"tenant":"raymondjames","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Raymond James');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Regeneron', 'workday', 'https://careers.regeneron.com', '{"tenant":"regeneron","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Regeneron');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'RELX', 'workday', 'https://www.relx.com/careers', '{"tenant":"relx","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'RELX');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Republic Services', 'workday', 'https://careers.republicservices.com', '{"tenant":"republicservices","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Republic Services');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ResMed', 'workday', 'https://jobs.resmed.com', '{"tenant":"resmed","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ResMed');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rio Tinto', 'workday', 'https://careers.riotinto.com', '{"tenant":"riotinto","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rio Tinto');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rocket Companies', 'workday', 'https://careers.rocket.com', '{"tenant":"rocket","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rocket Companies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rocket Lab', 'workday', 'https://www.rocketlabusa.com/careers/', '{"tenant":"rocketlab","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rocket Lab');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rockwell Automation', 'workday', 'https://careers.rockwellautomation.com', '{"tenant":"rockwellautomation","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rockwell Automation');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Roper Technologies', 'workday', 'https://roper.com/careers', '{"tenant":"ropertech","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Roper Technologies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ross Stores', 'workday', 'https://jobs.rossstores.com', '{"tenant":"rossstores","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ross Stores');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Royal Caribbean', 'workday', 'https://careers.royalcaribbeangroup.com', '{"tenant":"royalcaribbean","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Royal Caribbean');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Royalty Pharma', 'workday', 'https://www.royaltypharma.com/careers', '{"tenant":"royaltypharma","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Royalty Pharma');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sanofi', 'workday', 'https://sanofi.com/en/careers', '{"tenant":"sanofi","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sanofi');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Seagate', 'workday', 'https://jobs.seagate.com', '{"tenant":"seagate","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Seagate');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sempra', 'workday', 'https://jobs.sempra.com', '{"tenant":"sempra","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sempra');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sherwin-Williams', 'workday', 'https://careers.sherwin-williams.com', '{"tenant":"sherwinwilliams","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sherwin-Williams');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Simon Property', 'workday', 'https://www.simon.com/careers', '{"tenant":"simon","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Simon Property');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'SLB (Schlumberger)', 'workday', 'https://careers.slb.com', '{"tenant":"slb","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'SLB (Schlumberger)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Snowflake', 'workday', 'https://careers.snowflake.com', '{"tenant":"snowflake","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Snowflake');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Southern Company', 'workday', 'https://careers.southerncompany.com', '{"tenant":"southernco","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Southern Company');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Starbucks', 'workday', 'https://careers.starbucks.com', '{"tenant":"starbucks","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Starbucks');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Steel Dynamics', 'workday', 'https://www.steeldynamics.com/careers', '{"tenant":"steeldynamics","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Steel Dynamics');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sterling Infrastructure', 'workday', 'https://sterlingrsg.com/careers', '{"tenant":"sterling","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sterling Infrastructure');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'STMicroelectronics', 'workday', 'https://www.st.com/content/st_com/en/about/careers.html', '{"tenant":"st","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'STMicroelectronics');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Strategy (MicroStrategy)', 'workday', 'https://www.microstrategy.com/careers', '{"tenant":"microstrategy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Strategy (MicroStrategy)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sun Life Financial', 'workday', 'https://sunlife.com/careers', '{"tenant":"sunlife","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sun Life Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Suncor Energy', 'workday', 'https://careers.suncor.com', '{"tenant":"suncor","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Suncor Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Super Micro Computer', 'workday', 'https://careers.supermicro.com', '{"tenant":"supermicro","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Super Micro Computer');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Synopsys', 'workday', 'https://www.synopsys.com/company/job-search.html', '{"tenant":"synopsys","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Synopsys');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sysco', 'workday', 'https://jobs.sysco.com', '{"tenant":"sysco","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sysco');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Take-Two Interactive', 'workday', 'https://careers.take2games.com', '{"tenant":"take2","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Take-Two Interactive');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Targa Resources', 'workday', 'https://careers.targaresources.com', '{"tenant":"targaresources","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Targa Resources');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TC Energy', 'workday', 'https://careers.tcenergy.com', '{"tenant":"tcenergy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TC Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TE Connectivity', 'workday', 'https://jobs.te.com', '{"tenant":"te","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TE Connectivity');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TechnipFMC', 'workday', 'https://www.technipfmc.com/careers', '{"tenant":"technipfmc","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TechnipFMC');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Teck Resources', 'workday', 'https://jobs.teck.com', '{"tenant":"teck","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Teck Resources');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Teradyne', 'workday', 'https://jobs.teradyne.com', '{"tenant":"teradyne","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Teradyne');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Teva Pharma', 'workday', 'https://careers.teva', '{"tenant":"teva","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Teva Pharma');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Texas Pacific Land', 'workday', 'https://texaspacific.com/careers', '{"tenant":"tpl","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Texas Pacific Land');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Thermo Fisher', 'workday', 'https://jobs.thermofisher.com', '{"tenant":"thermofisher","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Thermo Fisher');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TJX Companies', 'workday', 'https://careers.tjx.com', '{"tenant":"tjx","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TJX Companies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TKO Group', 'workday', 'https://tkogroupholdings.com/careers', '{"tenant":"tko","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TKO Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TotalEnergies', 'workday', 'https://careers.totalenergies.com', '{"tenant":"totalenergies","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TotalEnergies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TransDigm', 'workday', 'https://www.transdigm.com/careers', '{"tenant":"transdigm","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TransDigm');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ubiquiti', 'workday', 'https://www.ui.com/careers/', '{"tenant":"ubiquiti","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ubiquiti');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'UBS Group', 'workday', 'https://www.ubs.com/global/en/careers.html', '{"tenant":"ubs","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'UBS Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Union Pacific', 'workday', 'https://up.jobs', '{"tenant":"up","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Union Pacific');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'United Airlines', 'workday', 'https://careers.united.com', '{"tenant":"united","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'United Airlines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'United Rentals', 'workday', 'https://jobs.ur.com', '{"tenant":"ur","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'United Rentals');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'UnitedHealth (Optum)', 'workday', 'https://careers.unitedhealthgroup.com', '{"tenant":"uhg","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'UnitedHealth (Optum)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'UPS', 'workday', 'https://www.jobs-ups.com', '{"tenant":"ups","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'UPS');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Valero Energy', 'workday', 'https://careers.valero.com', '{"tenant":"valero","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Valero Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Venture Global', 'workday', 'https://ventureglobal.com/careers', '{"tenant":"ventureglobal","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Venture Global');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'VeriSign', 'workday', 'https://www.verisign.com/en_US/company-information/careers/', '{"tenant":"verisign","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'VeriSign');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Vertex Pharma', 'workday', 'https://www.vrtx.com/careers', '{"tenant":"vrtx","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Vertex Pharma');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'VICI Properties', 'workday', 'https://viciproperties.com/careers', '{"tenant":"vici","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'VICI Properties');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Viking Holdings', 'workday', 'https://www.vikingcruises.com/careers', '{"tenant":"viking","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Viking Holdings');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Vistra', 'workday', 'https://vistra.com/careers', '{"tenant":"vistra","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Vistra');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Vodafone', 'workday', 'https://careers.vodafone.com', '{"tenant":"vodafone","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Vodafone');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Vulcan Materials', 'workday', 'https://www.vulcanmaterials.com/careers', '{"tenant":"vulcanmaterials","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Vulcan Materials');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'W.W. Grainger', 'workday', 'https://jobs.grainger.com', '{"tenant":"grainger","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'W.W. Grainger');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Wabtec', 'workday', 'https://careers.wabtec.com', '{"tenant":"wabtec","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Wabtec');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Walt Disney', 'workday', 'https://jobs.disneycareers.com', '{"tenant":"disney","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Walt Disney');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Waste Connections', 'workday', 'https://careers.wasteconnections.com', '{"tenant":"wasteconnections","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Waste Connections');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Waste Management', 'workday', 'https://careers.wm.com', '{"tenant":"wm","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Waste Management');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Waters', 'workday', 'https://careers.waters.com', '{"tenant":"waters","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Waters');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'WEC Energy', 'workday', 'https://careers.wecenergygroup.com', '{"tenant":"wecenergy","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'WEC Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Wells Fargo', 'workday', 'https://www.wellsfargo.com/about/careers/', '{"tenant":"wellsfargo","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Wells Fargo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Welltower', 'workday', 'https://welltower.com/careers', '{"tenant":"welltower","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Welltower');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Western Digital', 'workday', 'https://www.westerndigital.com/company/careers', '{"tenant":"westerndigital","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Western Digital');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Wheaton Precious Metals', 'workday', 'https://www.wheatonpm.com/careers', '{"tenant":"wheatonpm","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Wheaton Precious Metals');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Woodside Energy', 'workday', 'https://www.woodside.com/careers', '{"tenant":"woodside","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Woodside Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Yum! Brands', 'workday', 'https://careers.yum.com', '{"tenant":"yum","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Yum! Brands');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Zoom', 'workday', 'https://careers.zoom.us', '{"tenant":"zoom","instance":"wd1"}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Zoom');

-- -------------------------------------------------------
-- GREENHOUSE (slugs known)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Airbnb', 'greenhouse', 'https://careers.airbnb.com', '{"slug":"airbnb"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Airbnb');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AppLovin', 'greenhouse', 'https://www.applovin.com/careers/', '{"slug":"applovin"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AppLovin');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AST SpaceMobile', 'greenhouse', 'https://ast-science.com/careers', '{"slug":"ast-science"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AST SpaceMobile');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Astera Labs', 'greenhouse', 'https://www.asteralabs.com/careers/', '{"slug":"asteralabs"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Astera Labs');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Axon Enterprise', 'greenhouse', 'https://www.axon.com/careers', '{"slug":"axon"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Axon Enterprise');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cerebras Systems', 'greenhouse', 'https://www.cerebras.ai/join-us', '{"slug":"cerebras"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cerebras Systems');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cloudflare', 'greenhouse', 'https://careers.cloudflare.com', '{"slug":"cloudflare"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cloudflare');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coinbase', 'greenhouse', 'https://www.coinbase.com/careers', '{"slug":"coinbase"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coinbase');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CoreWeave', 'greenhouse', 'https://coreweave.com/careers', '{"slug":"coreweave"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CoreWeave');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coupang', 'greenhouse', 'https://www.coupang.jobs', '{"slug":"coupang"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coupang');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Credo Technology', 'greenhouse', 'https://www.credosemi.com/careers', '{"slug":"credosemi"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Credo Technology');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Datadog', 'greenhouse', 'https://careers.datadoghq.com', '{"slug":"datadoghq"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Datadog');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MongoDB', 'greenhouse', 'https://www.mongodb.com/careers', '{"slug":"mongodb"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MongoDB');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nebius Group', 'greenhouse', 'https://nebius.com/careers', '{"slug":"nebius"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nebius Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Reddit', 'greenhouse', 'https://www.redditinc.com/careers', '{"slug":"reddit"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Reddit');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Revolution Medicines', 'greenhouse', 'https://www.revmed.com/careers', '{"slug":"revolutionmedicines"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Revolution Medicines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Robinhood', 'greenhouse', 'https://careers.robinhood.com/', '{"slug":"robinhood"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Robinhood');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Roblox', 'greenhouse', 'https://careers.roblox.com', '{"slug":"roblox"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Roblox');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sea Limited', 'greenhouse', 'https://careers.sea.com', '{"slug":"sea"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sea Limited');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Spotify', 'greenhouse', 'https://jobs.spotify.com', '{"slug":"spotify"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Spotify');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Symbotic', 'greenhouse', 'https://www.symbotic.com/careers', '{"slug":"symbotic"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Symbotic');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Twilio', 'greenhouse', 'https://www.twilio.com/en-us/company/jobs', '{"slug":"twilio"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Twilio');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Uber', 'greenhouse', 'https://www.uber.com/us/en/careers/', '{"slug":"uber"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Uber');

-- -------------------------------------------------------
-- LEVER
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Palantir', 'lever', 'https://www.palantir.com/careers/', '{"slug":"palantir"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Palantir');

-- -------------------------------------------------------
-- SMARTRECRUITERS
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'SanDisk', 'smartrecruiters', 'https://www.sandisk.com/careers/jobs-at-sandisk', '{"slug":"SanDisk"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'SanDisk');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Visa', 'smartrecruiters', 'https://careers.visa.com', '{"slug":"visa"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Visa');

-- -------------------------------------------------------
-- EIGHTFOLD
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MercadoLibre', 'eightfold', 'https://careers-meli.mercadolibre.com/en', '{"domain":"mercadolibre.com","careers_url":"https://careers-meli.mercadolibre.com/en"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MercadoLibre');

-- -------------------------------------------------------
-- iCIMS — inactive (need domain per company)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Costco', 'icims', 'https://careers.costco.com', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Costco');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CVS Health', 'icims', 'https://jobs.cvshealth.com', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CVS Health');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Home Depot', 'icims', 'https://careers.homedepot.com', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Home Depot');

-- -------------------------------------------------------
-- SKIPPED — no scraper: custom / SuccessFactors / Taleo / Oracle
-- -------------------------------------------------------
-- Alibaba                                       [custom]
-- Alphabet (Google)                             [custom]
-- Amazon                                        [custom]
-- America Movil                                 [custom]
-- Amrize                                        [SuccessFactors]
-- Apple                                         [custom]
-- ASE Technology                                [custom]
-- Baidu                                         [custom]
-- Banco Bradesco                                [custom]
-- Banco Santander                               [SuccessFactors]
-- BBVA                                          [custom]
-- Boeing                                        [Taleo]
-- Chunghwa Telecom                              [custom]
-- Ecopetrol                                     [custom]
-- Elbit Systems                                 [custom]
-- Eni                                           [custom]
-- Exxon Mobil                                   [SuccessFactors]
-- FEMSA                                         [custom]
-- Ferrari                                       [custom]
-- Ferrovial                                     [custom]
-- HDFC Bank                                     [custom]
-- Honda Motor                                   [custom]
-- ICICI Bank                                    [custom]
-- Infosys                                       [custom]
-- Itau Unibanco                                 [custom]
-- JD.com                                        [custom]
-- KB Financial                                  [custom]
-- Meta                                          [custom]
-- Microsoft                                     [custom]
-- Mitsubishi UFJ                                [custom]
-- Mizuho                                        [custom]
-- NetEase                                       [custom]
-- Nu Holdings                                   [custom]
-- Oracle                                        [Oracle Recruiting Cloud]
-- ORIX                                          [custom]
-- PDD Holdings                                  [custom]
-- Petrobras                                     [custom]
-- Petrobras (A)                                 [custom]
-- Prudential plc                                [custom]
-- Ryanair                                       [custom]
-- Shinhan Financial                             [custom]
-- Sony Group                                    [custom]
-- Southern Copper                               [custom]
-- Sumitomo Mitsui                               [custom]
-- Tenaris                                       [custom]
-- Texas Instruments                             [custom]
-- Tower Semiconductor                           [custom]
-- Toyota (N.A.)                                 [custom]
-- Trip.com                                      [custom]
-- TSMC                                          [custom]
-- United Microelectronics                       [custom]
-- Vale                                          [custom]
-- Veeva Systems                                 [custom]
-- Vertiv                                        [Oracle Recruiting Cloud]

-- ============================================================
-- ACTIVATION PASS (verified Workday tenants)
-- ============================================================

-- Activate Workday companies whose guessed tenant slug verified OK
-- Site chosen = board with most live jobs on the tenant

UPDATE companies SET active = true, ats_config = '{"tenant": "3m", "instance": "wd1", "site": "Search"}'::jsonb WHERE company_name = '3M' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "aig", "instance": "wd1", "site": "aig"}'::jsonb WHERE company_name = 'AIG' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "asml", "instance": "wd3", "site": "ASMLBERLIN"}'::jsonb WHERE company_name = 'ASML' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "agilent", "instance": "wd5", "site": "Agilent_Careers"}'::jsonb WHERE company_name = 'Agilent' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "allstate", "instance": "wd5", "site": "allstate_careers"}'::jsonb WHERE company_name = 'Allstate' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "ameriprise", "instance": "wd5", "site": "Ameriprise"}'::jsonb WHERE company_name = 'Ameriprise Financial' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "astrazeneca", "instance": "wd3", "site": "Careers"}'::jsonb WHERE company_name = 'AstraZeneca' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "atmosenergy", "instance": "wd108", "site": "External_Career_Site"}'::jsonb WHERE company_name = 'Atmos Energy' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "autodesk", "instance": "wd1", "site": "Ext"}'::jsonb WHERE company_name = 'Autodesk' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "blackrock", "instance": "wd1", "site": "BlackRock_Professional"}'::jsonb WHERE company_name = 'BlackRock' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "broadcom", "instance": "wd1", "site": "External_Career"}'::jsonb WHERE company_name = 'Broadcom' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "cibc", "instance": "wd3", "site": "search"}'::jsonb WHERE company_name = 'CIBC' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "cmegroup", "instance": "wd1", "site": "cme_careers"}'::jsonb WHERE company_name = 'CME Group' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "cardinalhealth", "instance": "wd1", "site": "EXT"}'::jsonb WHERE company_name = 'Cardinal Health' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "carrier", "instance": "wd5", "site": "jobs"}'::jsonb WHERE company_name = 'Carrier Global' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "cboe", "instance": "wd1", "site": "External_Career_CBOE"}'::jsonb WHERE company_name = 'Cboe Global Markets' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "cenovus", "instance": "wd3", "site": "careers"}'::jsonb WHERE company_name = 'Cenovus Energy' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "chevron", "instance": "wd5", "site": "jobs"}'::jsonb WHERE company_name = 'Chevron' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "chipotle", "instance": "wd5", "site": "ChipotleCareers"}'::jsonb WHERE company_name = 'Chipotle' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "cisco", "instance": "wd5", "site": "Cisco_Careers"}'::jsonb WHERE company_name = 'Cisco' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "copart", "instance": "wd12", "site": "Copart"}'::jsonb WHERE company_name = 'Copart' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "dexcom", "instance": "wd1", "site": "Dexcom"}'::jsonb WHERE company_name = 'DexCom' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "diamondbackenergy", "instance": "wd12", "site": "DBE"}'::jsonb WHERE company_name = 'Diamondback Energy' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "echostar", "instance": "wd501", "site": "echostar"}'::jsonb WHERE company_name = 'EchoStar' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "edwards", "instance": "wd5", "site": "EdwardsCareers"}'::jsonb WHERE company_name = 'Edwards Lifesciences' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "emerson", "instance": "wd5", "site": "Emerson_College_Staff"}'::jsonb WHERE company_name = 'Emerson Electric' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "enbridge", "instance": "wd3", "site": "enbridge_careers"}'::jsonb WHERE company_name = 'Enbridge' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "extraspace", "instance": "wd5", "site": "ESS_External"}'::jsonb WHERE company_name = 'Extra Space Storage' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "fedex", "instance": "wd1", "site": "FXE-EU_External"}'::jsonb WHERE company_name = 'FedEx' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "ferguson", "instance": "wd1", "site": "Ferguson_Experienced"}'::jsonb WHERE company_name = 'Ferguson' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "fifththird", "instance": "wd5", "site": "53careers"}'::jsonb WHERE company_name = 'Fifth Third Bancorp' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "fiserv", "instance": "wd5", "site": "EXT"}'::jsonb WHERE company_name = 'Fiserv' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "gevernova", "instance": "wd5", "site": "Vernova_ExternalSite"}'::jsonb WHERE company_name = 'GE Vernova' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "gsk", "instance": "wd5", "site": "GSKCareers"}'::jsonb WHERE company_name = 'GSK' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "generalmotors", "instance": "wd5", "site": "Careers_GM"}'::jsonb WHERE company_name = 'General Motors' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "thehartford", "instance": "wd5", "site": "Careers_External"}'::jsonb WHERE company_name = 'Hartford Insurance' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "ing", "instance": "wd3", "site": "ICSGBLCOR"}'::jsonb WHERE company_name = 'ING Groep' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "intuitive", "instance": "wd1", "site": "irtc_careers"}'::jsonb WHERE company_name = 'Intuitive Surgical' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "ironmountain", "instance": "wd5", "site": "iron-mountain-jobs"}'::jsonb WHERE company_name = 'Iron Mountain' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "kimberlyclark", "instance": "wd1", "site": "GLOBAL"}'::jsonb WHERE company_name = 'Kimberly-Clark' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "sands", "instance": "wd1", "site": "sands_careers"}'::jsonb WHERE company_name = 'Las Vegas Sands' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "mtb", "instance": "wd5", "site": "MTB"}'::jsonb WHERE company_name = 'M&T Bank' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "mpc", "instance": "wd1", "site": "MPCCareers"}'::jsonb WHERE company_name = 'MPLX' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "manulife", "instance": "wd3", "site": "MFCJH_Jobs"}'::jsonb WHERE company_name = 'Manulife Financial' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "mpc", "instance": "wd1", "site": "MPCCareers"}'::jsonb WHERE company_name = 'Marathon Petroleum' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "mckesson", "instance": "wd3", "site": "External_Careers"}'::jsonb WHERE company_name = 'McKesson' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "medline", "instance": "wd5", "site": "Medline"}'::jsonb WHERE company_name = 'Medline' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "medtronic", "instance": "wd1", "site": "MedtronicCareers"}'::jsonb WHERE company_name = 'Medtronic' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "nvidia", "instance": "wd5", "site": "NVIDIAExternalCareerSite"}'::jsonb WHERE company_name = 'NVIDIA' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "nxp", "instance": "wd3", "site": "careers"}'::jsonb WHERE company_name = 'NXP Semiconductors' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "nasdaq", "instance": "wd1", "site": "Global_External_Site"}'::jsonb WHERE company_name = 'Nasdaq' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "netflix", "instance": "wd108", "site": "Netflix"}'::jsonb WHERE company_name = 'Netflix' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "pfizer", "instance": "wd1", "site": "PfizerCareers"}'::jsonb WHERE company_name = 'Pfizer' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "prologis", "instance": "wd5", "site": "Prologis_External_Careers"}'::jsonb WHERE company_name = 'Prologis' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "relx", "instance": "wd3", "site": "relx"}'::jsonb WHERE company_name = 'RELX' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "raymondjames", "instance": "wd1", "site": "RaymondJamesCareers"}'::jsonb WHERE company_name = 'Raymond James' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "regeneron", "instance": "wd1", "site": "Careers"}'::jsonb WHERE company_name = 'Regeneron' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "resmed", "instance": "wd3", "site": "ResMed_External_Careers"}'::jsonb WHERE company_name = 'ResMed' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "rocket", "instance": "wd5", "site": "rocket_careers"}'::jsonb WHERE company_name = 'Rocket Companies' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "rockwellautomation", "instance": "wd1", "site": "External_Rockwell_Automation"}'::jsonb WHERE company_name = 'Rockwell Automation' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "sanofi", "instance": "wd3", "site": "SanofiCareers"}'::jsonb WHERE company_name = 'Sanofi' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "simon", "instance": "wd1", "site": "Simon"}'::jsonb WHERE company_name = 'Simon Property' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "sunlife", "instance": "wd3", "site": "Experienced-Jobs"}'::jsonb WHERE company_name = 'Sun Life Financial' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "suncor", "instance": "wd1", "site": "Suncor_External"}'::jsonb WHERE company_name = 'Suncor Energy' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "tcenergy", "instance": "wd3", "site": "CAREER_SITE_TC"}'::jsonb WHERE company_name = 'TC Energy' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "ur", "instance": "wd1", "site": "URcareers"}'::jsonb WHERE company_name = 'United Rentals' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "vrtx", "instance": "wd501", "site": "Vertex_Careers"}'::jsonb WHERE company_name = 'Vertex Pharma' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "disney", "instance": "wd5", "site": "disneycareer"}'::jsonb WHERE company_name = 'Walt Disney' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "wasteconnections", "instance": "wd1", "site": "Careers"}'::jsonb WHERE company_name = 'Waste Connections' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "ebay", "instance": "wd5", "site": "TCGPlayer_External_Career"}'::jsonb WHERE company_name = 'eBay' AND ats = 'workday';
UPDATE companies SET active = true, ats_config = '{"tenant": "nvent", "instance": "wd5", "site": "nVent"}'::jsonb WHERE company_name = 'nVent Electric' AND ats = 'workday';
