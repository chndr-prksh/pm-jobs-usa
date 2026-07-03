-- ============================================================
-- BATCH 9: 486 new companies from Fortune-500 / large-cap list
-- ============================================================

-- -------------------------------------------------------
-- WORKDAY (tenant extracted from URL where possible)
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT '3M', 'workday', 'https://www.3m.com/3M/en_US/careers-us/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = '3M');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Abbott', 'workday', 'https://www.jobs.abbott', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Abbott');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AbbVie', 'workday', 'https://careers.abbvie.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AbbVie');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Accenture', 'workday', 'https://www.accenture.com/us-en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Accenture');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Adobe', 'workday', 'https://careers.adobe.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Adobe');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Aflac', 'workday', 'https://careers.aflac.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Aflac');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Agilent', 'workday', 'https://jobs.agilent.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Agilent');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Agnico Eagle Mines', 'workday', 'https://agnicoeagle.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Agnico Eagle Mines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AIG', 'workday', 'https://careers.aig.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AIG');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Air Products', 'workday', 'https://www.airproducts.com/company/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Air Products');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Alcon', 'workday', 'https://www.alcon.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Alcon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Allstate', 'workday', 'https://careers.allstate.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Allstate');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Alnylam Pharma', 'workday', 'https://www.alnylam.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Alnylam Pharma');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Altria', 'workday', 'https://careers.altria.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Altria');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ambev', 'workday', 'https://www.ambev.com.br/carreiras/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ambev');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AMD', 'workday', 'https://careers.amd.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AMD');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ameren', 'workday', 'https://ameren.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ameren');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'American Electric Power', 'workday', 'https://aep.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'American Electric Power');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'American Express', 'workday', 'https://careers.americanexpress.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'American Express');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'American Tower', 'workday', 'https://careers.americantower.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'American Tower');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ameriprise Financial', 'workday', 'https://www.ameriprise.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ameriprise Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AMETEK', 'workday', 'https://www.ametek.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AMETEK');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Amgen', 'workday', 'https://careers.amgen.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Amgen');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Amphenol', 'workday', 'https://careers.amphenol.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Amphenol');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Analog Devices', 'workday', 'https://www.analog.com/en/about-adi/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Analog Devices');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AngloGold Ashanti', 'workday', 'https://www.anglogoldashanti.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AngloGold Ashanti');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Anheuser-Busch InBev', 'workday', 'https://careers.ab-inbev.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Anheuser-Busch InBev');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Aon', 'workday', 'https://careers.aon.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Aon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Apollo Global Mgmt', 'workday', 'https://www.apollo.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Apollo Global Mgmt');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Applied Materials', 'workday', 'https://careers.appliedmaterials.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Applied Materials');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ArcelorMittal', 'workday', 'https://careers.arcelormittal.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ArcelorMittal');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Arch Capital', 'workday', 'https://www.archcapgroup.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Arch Capital');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Archer-Daniels-Midland', 'workday', 'https://careers.adm.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Archer-Daniels-Midland');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ares Management', 'workday', 'https://www.aresmgmt.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ares Management');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'argenx', 'workday', 'https://www.argenx.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'argenx');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Arista Networks', 'workday', 'https://www.arista.com/en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Arista Networks');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Arm Holdings', 'workday', 'https://careers.arm.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Arm Holdings');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Arthur J. Gallagher', 'workday', 'https://careers.ajg.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Arthur J. Gallagher');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ASML', 'workday', 'https://www.asml.com/en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ASML');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AstraZeneca', 'workday', 'https://careers.astrazeneca.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AstraZeneca');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AT&T', 'workday', 'https://www.att.jobs', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AT&T');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Atmos Energy', 'workday', 'https://careers.atmosenergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Atmos Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Autodesk', 'workday', 'https://www.autodesk.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Autodesk');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AutoZone', 'workday', 'https://careers.autozone.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AutoZone');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Baker Hughes', 'workday', 'https://careers.bakerhughes.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Baker Hughes');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bank of America', 'workday', 'https://careers.bankofamerica.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bank of America');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bank of Montreal', 'workday', 'https://jobs.bmo.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bank of Montreal');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bank of Nova Scotia', 'workday', 'https://jobs.scotiabank.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bank of Nova Scotia');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Barclays', 'workday', 'https://search.jobs.barclays', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Barclays');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Barrick Mining', 'workday', 'https://www.barrick.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Barrick Mining');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Becton Dickinson', 'workday', 'https://jobs.bd.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Becton Dickinson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BeOne Medicines', 'workday', 'https://beonemedicines.com/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BeOne Medicines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BHP Group', 'workday', 'https://www.bhp.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BHP Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Biogen', 'workday', 'https://www.biogen.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Biogen');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BlackRock', 'workday', 'https://careers.blackrock.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BlackRock');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Blackstone', 'workday', 'https://www.blackstone.com/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Blackstone');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bloom Energy', 'workday', 'https://www.bloomenergy.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bloom Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BNY Mellon', 'workday', 'https://bny.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BNY Mellon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Booking Holdings', 'workday', 'https://careers.bookingholdings.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Booking Holdings');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Boston Scientific', 'workday', 'https://jobs.bostonscientific.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Boston Scientific');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'BP', 'workday', 'https://www.bp.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'BP');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Bristol-Myers Squibb', 'workday', 'https://careers.bms.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Bristol-Myers Squibb');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'British American Tobacco', 'workday', 'https://www.bat.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'British American Tobacco');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Broadcom', 'workday', 'https://careers.broadcom.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Broadcom');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Brookfield Asset Mgmt', 'workday', 'https://www.brookfield.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Brookfield Asset Mgmt');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Brookfield Corp', 'workday', 'https://www.brookfield.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Brookfield Corp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cadence Design', 'workday', 'https://www.cadence.com/en_US/home/company/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cadence Design');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cameco', 'workday', 'https://www.cameco.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cameco');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Canadian National Rail', 'workday', 'https://www.cn.ca/en/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Canadian National Rail');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Canadian Natural Res', 'workday', 'https://www.cnrl.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Canadian Natural Res');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Canadian Pacific KC', 'workday', 'https://careers.cpkcr.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Canadian Pacific KC');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Capital One', 'workday', 'https://www.capitalonecareers.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Capital One');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cardinal Health', 'workday', 'https://jobs.cardinalhealth.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cardinal Health');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Carnival', 'workday', 'https://jobs.carnival.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Carnival');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Carrier Global', 'workday', 'https://careers.carrier.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Carrier Global');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Casey''s General Stores', 'workday', 'https://careers.caseys.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Casey''s General Stores');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Caterpillar', 'workday', 'https://careers.caterpillar.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Caterpillar');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cboe Global Markets', 'workday', 'https://careers.cboe.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cboe Global Markets');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CBRE Group', 'workday', 'https://careers.cbre.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CBRE Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Celestica', 'workday', 'https://www.celestica.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Celestica');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cencora', 'workday', 'https://careers.cencora.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cencora');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cenovus Energy', 'workday', 'https://careers.cenovus.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cenovus Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Centene', 'workday', 'https://jobs.centene.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Centene');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CenterPoint Energy', 'workday', 'https://jobs.centerpointenergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CenterPoint Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Charles Schwab', 'workday', 'https://www.schwab.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Charles Schwab');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cheniere Energy', 'workday', 'https://careers.cheniere.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cheniere Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cheniere Energy Partners', 'workday', 'https://careers.cheniere.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cheniere Energy Partners');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Chevron', 'workday', 'https://www.chevron.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Chevron');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Chipotle', 'workday', 'https://jobs.chipotle.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Chipotle');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Chubb', 'workday', 'https://careers.chubb.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Chubb');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CIBC', 'workday', 'https://www.cibc.com/en/about-cibc/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CIBC');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ciena', 'workday', 'https://careers.ciena.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ciena');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cigna', 'workday', 'https://jobs.cigna.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cigna');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cintas', 'workday', 'https://careers.cintas.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cintas');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cisco', 'workday', 'https://jobs.cisco.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cisco');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Citigroup', 'workday', 'https://careers.citi.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Citigroup');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CME Group', 'workday', 'https://careers.cmegroup.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CME Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coca-Cola', 'workday', 'https://careers.coca-colacompany.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coca-Cola');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coca-Cola Europacific', 'workday', 'https://careers.ccep.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coca-Cola Europacific');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coherent', 'workday', 'https://careers.coherent.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coherent');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Colgate-Palmolive', 'workday', 'https://jobs.colgate.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Colgate-Palmolive');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Comcast', 'workday', 'https://jobs.comcast.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Comcast');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Comfort Systems USA', 'workday', 'https://www.comfortsystemsusa.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Comfort Systems USA');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ConocoPhillips', 'workday', 'https://careers.conocophillips.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ConocoPhillips');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Consolidated Edison', 'workday', 'https://careers.coned.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Consolidated Edison');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Constellation Energy', 'workday', 'https://careers.constellationenergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Constellation Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Copart', 'workday', 'https://www.copart.com/content/us/en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Copart');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Corning', 'workday', 'https://www.corning.com/worldwide/en/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Corning');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Corteva', 'workday', 'https://careers.corteva.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Corteva');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CRH', 'workday', 'https://www.crh.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CRH');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CrowdStrike', 'workday', 'https://www.crowdstrike.com/en-us/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CrowdStrike');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Crown Castle', 'workday', 'https://careers.crowncastle.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Crown Castle');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CSX', 'workday', 'https://jobs.csx.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CSX');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cummins', 'workday', 'https://careers.cummins.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cummins');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Curtiss-Wright', 'workday', 'https://www.curtisswright.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Curtiss-Wright');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'D.R. Horton', 'workday', 'https://careers.drhorton.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'D.R. Horton');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Danaher', 'workday', 'https://jobs.danaher.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Danaher');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Deere', 'workday', 'https://jobs.deere.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Deere');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Dell', 'workday', 'https://jobs.dell.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Dell');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Delta Air Lines', 'workday', 'https://www.deltaairlines.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Delta Air Lines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Deutsche Bank', 'workday', 'https://careers.db.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Deutsche Bank');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Devon Energy', 'workday', 'https://www.devonenergy.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Devon Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'DexCom', 'workday', 'https://careers.dexcom.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'DexCom');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Diageo', 'workday', 'https://www.diageo.com/en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Diageo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Diamondback Energy', 'workday', 'https://careers.diamondbackenergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Diamondback Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Digital Realty', 'workday', 'https://careers.digitalrealty.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Digital Realty');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Dominion Energy', 'workday', 'https://careers.dominionenergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Dominion Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Dover', 'workday', 'https://www.dovercorporation.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Dover');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'DTE Energy', 'workday', 'https://careers.dteenergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'DTE Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Duke Energy', 'workday', 'https://careers.duke-energy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Duke Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Eaton', 'workday', 'https://careers.eaton.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Eaton');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'eBay', 'workday', 'https://careers.ebayinc.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'eBay');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EchoStar', 'workday', 'https://careers.echostar.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EchoStar');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ecolab', 'workday', 'https://careers.ecolab.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ecolab');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Edison International', 'workday', 'https://www.edisoninternational.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Edison International');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Edwards Lifesciences', 'workday', 'https://careers.edwards.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Edwards Lifesciences');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Electronic Arts', 'workday', 'https://jobs.ea.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Electronic Arts');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Elevance Health', 'workday', 'https://www.elevancehealth.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Elevance Health');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Eli Lilly', 'workday', 'https://careers.lilly.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Eli Lilly');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EMCOR Group', 'workday', 'https://emcor.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EMCOR Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Emerson Electric', 'workday', 'https://www.emerson.com/en-us/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Emerson Electric');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Enbridge', 'workday', 'https://www.enbridge.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Enbridge');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Energy Transfer', 'workday', 'https://www.energytransfer.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Energy Transfer');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Entergy', 'workday', 'https://jobs.entergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Entergy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Enterprise Products', 'workday', 'https://www.enterpriseproducts.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Enterprise Products');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EOG Resources', 'workday', 'https://careers.eogresources.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EOG Resources');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'EQT Corp', 'workday', 'https://careers.eqt.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'EQT Corp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Equinix', 'workday', 'https://careers.equinix.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Equinix');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Equinor', 'workday', 'https://www.equinor.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Equinor');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ericsson', 'workday', 'https://www.ericsson.com/en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ericsson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Estee Lauder', 'workday', 'https://careers.elcompanies.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Estee Lauder');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Exelon', 'workday', 'https://careers.exeloncorp.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Exelon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Extra Space Storage', 'workday', 'https://careers.extraspace.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Extra Space Storage');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fair Isaac (FICO)', 'workday', 'https://www.fico.com/en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fair Isaac (FICO)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fastenal', 'workday', 'https://careers.fastenal.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fastenal');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'FedEx', 'workday', 'https://careers.fedex.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'FedEx');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ferguson', 'workday', 'https://careers.ferguson.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ferguson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fifth Third Bancorp', 'workday', 'https://www.53.com/content/fifth-third/en/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fifth Third Bancorp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'First Solar', 'workday', 'https://jobs.firstsolar.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'First Solar');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fiserv', 'workday', 'https://careers.fiserv.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fiserv');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Flex', 'workday', 'https://careers.flex.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Flex');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ford Motor', 'workday', 'https://careers.ford.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ford Motor');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fortinet', 'workday', 'https://www.fortinet.com/corporate/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fortinet');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Fortis', 'workday', 'https://careers.fortisinc.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Fortis');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Franco-Nevada', 'workday', 'https://www.franco-nevada.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Franco-Nevada');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Freeport-McMoRan', 'workday', 'https://careers.fcx.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Freeport-McMoRan');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Garmin', 'workday', 'https://careers.garmin.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Garmin');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GE Aerospace', 'workday', 'https://jobs.gecareers.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GE Aerospace');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GE HealthCare', 'workday', 'https://careers.gehealthcare.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GE HealthCare');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GE Vernova', 'workday', 'https://jobs.gecareers.com/vernova', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GE Vernova');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'General Dynamics', 'workday', 'https://www.gd.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'General Dynamics');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'General Motors', 'workday', 'https://careers.gm.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'General Motors');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Gilead Sciences', 'workday', 'https://www.gilead.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Gilead Sciences');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GLOBALFOUNDRIES', 'workday', 'https://gf.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GLOBALFOUNDRIES');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Gold Fields', 'workday', 'https://careers.goldfields.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Gold Fields');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Goldman Sachs', 'workday', 'https://www.goldmansachs.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Goldman Sachs');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'GSK', 'workday', 'https://careers.gsk.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'GSK');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Haleon', 'workday', 'https://www.haleon.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Haleon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Halliburton', 'workday', 'https://www.halliburton.com/en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Halliburton');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hartford Insurance', 'workday', 'https://www.thehartford.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hartford Insurance');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'HCA Healthcare', 'workday', 'https://careers.hcahealthcare.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'HCA Healthcare');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'HEICO', 'workday', 'https://www.heico.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'HEICO');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hershey', 'workday', 'https://careers.thehersheycompany.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hershey');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hewlett Packard Ent', 'workday', 'https://careers.hpe.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hewlett Packard Ent');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Hilton', 'workday', 'https://jobs.hilton.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Hilton');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Honeywell', 'workday', 'https://careers.honeywell.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Honeywell');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Howmet Aerospace', 'workday', 'https://careers.howmet.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Howmet Aerospace');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'HSBC', 'workday', 'https://www.hsbc.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'HSBC');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Humana', 'workday', 'https://careers.humana.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Humana');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Huntington Bancshares', 'workday', 'https://www.huntington.com/Careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Huntington Bancshares');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'IBM', 'workday', 'https://www.ibm.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'IBM');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'IDEXX Labs', 'workday', 'https://idexx.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'IDEXX Labs');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Illinois Tool Works', 'workday', 'https://careers.itw.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Illinois Tool Works');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Imperial Oil', 'workday', 'https://www.imperialoil.ca/en-CA/company/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Imperial Oil');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ING Groep', 'workday', 'https://www.ing.jobs', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ING Groep');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ingersoll Rand', 'workday', 'https://careers.irco.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ingersoll Rand');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Intel', 'workday', 'https://jobs.intel.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Intel');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Interactive Brokers', 'workday', 'https://www.interactivebrokers.com/en/general/about/jobs.php', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Interactive Brokers');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Intercontinental Exch', 'workday', 'https://careers.intercontinentalexchange.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Intercontinental Exch');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Intuit', 'workday', 'https://careers.intuit.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Intuit');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Intuitive Surgical', 'workday', 'https://careers.intuitive.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Intuitive Surgical');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'IQVIA', 'workday', 'https://jobs.iqvia.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'IQVIA');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Iron Mountain', 'workday', 'https://careers.ironmountain.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Iron Mountain');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Jabil', 'workday', 'https://jabil.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Jabil');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Johnson & Johnson', 'workday', 'https://jobs.jnj.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Johnson & Johnson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Johnson Controls', 'workday', 'https://jobs.johnsoncontrols.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Johnson Controls');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'JPMorgan Chase', 'workday', 'https://careers.jpmorgan.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'JPMorgan Chase');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kenvue', 'workday', 'https://careers.kenvue.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kenvue');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Keurig Dr Pepper', 'workday', 'https://careers.keurigdrpepper.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Keurig Dr Pepper');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Keysight', 'workday', 'https://jobs.keysight.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Keysight');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kimberly-Clark', 'workday', 'https://jobs.kimberly-clark.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kimberly-Clark');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kinder Morgan', 'workday', 'https://www.kindermorgan.com/Careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kinder Morgan');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kinross Gold', 'workday', 'https://careers.kinross.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kinross Gold');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'KKR', 'workday', 'https://www.kkr.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'KKR');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'KLA', 'workday', 'https://www.kla.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'KLA');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Kroger', 'workday', 'https://jobs.kroger.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Kroger');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'L3Harris', 'workday', 'https://careers.l3harris.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'L3Harris');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lam Research', 'workday', 'https://careers.lamresearch.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lam Research');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Las Vegas Sands', 'workday', 'https://jobs.lasvegassands.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Las Vegas Sands');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Linde', 'workday', 'https://jobs.linde.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Linde');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Live Nation', 'workday', 'https://www.livenationentertainment.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Live Nation');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lloyds Banking', 'workday', 'https://www.lloydsbankinggroup.com/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lloyds Banking');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lockheed Martin', 'workday', 'https://www.lockheedmartinjobs.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lockheed Martin');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lowe''s', 'workday', 'https://careers.lowes.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lowe''s');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Lumentum', 'workday', 'https://www.lumentum.com/en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Lumentum');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'M&T Bank', 'workday', 'https://careers.mtb.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'M&T Bank');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MACOM Technology', 'workday', 'https://www.macom.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MACOM Technology');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Manulife Financial', 'workday', 'https://jobs.manulife.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Manulife Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Marathon Petroleum', 'workday', 'https://careers.marathonpetroleum.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Marathon Petroleum');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Marriott', 'workday', 'https://careers.marriott.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Marriott');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Marsh & McLennan', 'workday', 'https://careers.mmc.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Marsh & McLennan');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Martin Marietta', 'workday', 'https://careers.martinmarietta.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Martin Marietta');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Marvell', 'workday', 'https://www.marvell.com/company/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Marvell');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MasTec', 'workday', 'https://mastec.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MasTec');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Mastercard', 'workday', 'https://careers.mastercard.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Mastercard');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'McDonald''s', 'workday', 'https://careers.mcdonalds.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'McDonald''s');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'McKesson', 'workday', 'https://careers.mckesson.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'McKesson');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Medline', 'workday', 'https://medline.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Medline');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Medtronic', 'workday', 'https://jobs.medtronic.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Medtronic');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Merck', 'workday', 'https://jobs.merck.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Merck');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MetLife', 'workday', 'https://jobs.metlife.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MetLife');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Microchip Technology', 'workday', 'https://careers.microchip.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Microchip Technology');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Micron', 'workday', 'https://www.micron.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Micron');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Mondelez', 'workday', 'https://careers.mondelezinternational.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Mondelez');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Monolithic Power', 'workday', 'https://www.monolithicpower.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Monolithic Power');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Monster Beverage', 'workday', 'https://careers.monsterbevcorp.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Monster Beverage');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Moody''s', 'workday', 'https://careers.moodys.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Moody''s');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Morgan Stanley', 'workday', 'https://www.morganstanley.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Morgan Stanley');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Motorola Solutions', 'workday', 'https://motorolasolutions.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Motorola Solutions');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MPLX', 'workday', 'https://careers.marathonpetroleum.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MPLX');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MSCI', 'workday', 'https://www.msci.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MSCI');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nasdaq', 'workday', 'https://nasdaq.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nasdaq');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Natera', 'workday', 'https://natera.com/company/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Natera');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'National Grid', 'workday', 'https://careers.nationalgrid.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'National Grid');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NatWest', 'workday', 'https://www.natwest.com/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NatWest');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NetApp', 'workday', 'https://careers.netapp.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NetApp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Netflix', 'workday', 'https://jobs.netflix.com/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Netflix');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Newmont', 'workday', 'https://newmont.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Newmont');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NextEra Energy', 'workday', 'https://careers.nexteraenergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NextEra Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nike', 'workday', 'https://nike.wd1.myworkdayjobs.com/nke/', '{"tenant":"nike","instance":"wd1"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nike');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nokia', 'workday', 'https://www.nokia.com/about-us/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nokia');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Norfolk Southern', 'workday', 'https://www.nscorp.com/content/nscorp/en/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Norfolk Southern');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Northern Trust', 'workday', 'https://careers.northerntrust.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Northern Trust');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Northrop Grumman', 'workday', 'https://www.northropgrumman.com/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Northrop Grumman');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Novartis', 'workday', 'https://www.novartis.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Novartis');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Novo Nordisk', 'workday', 'https://www.novonordisk.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Novo Nordisk');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NRG Energy', 'workday', 'https://careers.nrgenergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NRG Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nucor', 'workday', 'https://careers.nucor.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nucor');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nutrien', 'workday', 'https://nutrien.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nutrien');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'nVent Electric', 'workday', 'https://careers.nvent.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'nVent Electric');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NVIDIA', 'workday', 'https://www.nvidia.com/en-us/about-nvidia/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NVIDIA');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'NXP Semiconductors', 'workday', 'https://careers.nxp.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'NXP Semiconductors');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'O''Reilly Automotive', 'workday', 'https://careers.oreillyauto.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'O''Reilly Automotive');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Occidental Petroleum', 'workday', 'https://www.oxy.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Occidental Petroleum');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Old Dominion Freight', 'workday', 'https://www.odfl.com/us/en/about-od/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Old Dominion Freight');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ON Semiconductor', 'workday', 'https://www.onsemi.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ON Semiconductor');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ONEOK', 'workday', 'https://www.oneok.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ONEOK');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PACCAR', 'workday', 'https://careers.paccar.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PACCAR');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Palo Alto Networks', 'workday', 'https://careers.paloaltonetworks.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Palo Alto Networks');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Parker-Hannifin', 'workday', 'https://careers.parker.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Parker-Hannifin');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Paychex', 'workday', 'https://careers.paychex.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Paychex');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PayPal', 'workday', 'https://careers.pypl.com/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PayPal');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Pembina Pipeline', 'workday', 'https://careers.pembina.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Pembina Pipeline');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PepsiCo', 'workday', 'https://www.pepsicojobs.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PepsiCo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Pfizer', 'workday', 'https://www.pfizercareers.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Pfizer');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PG&E', 'workday', 'https://careers.pge.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PG&E');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Philip Morris Intl', 'workday', 'https://careers.pmi.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Philip Morris Intl');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Phillips 66', 'workday', 'https://careers.phillips66.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Phillips 66');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'PNC Financial', 'workday', 'https://www.pnc.com/en/about-pnc/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'PNC Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Procter & Gamble', 'workday', 'https://www.pgcareers.com/us/en', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Procter & Gamble');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Progressive', 'workday', 'https://www.progressive.com/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Progressive');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Prologis', 'workday', 'https://careers.prologis.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Prologis');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Prudential Financial', 'workday', 'https://jobs.prudential.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Prudential Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Public Service Enterprise', 'workday', 'https://jobs.pseg.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Public Service Enterprise');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Public Storage', 'workday', 'https://jobs.publicstorage.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Public Storage');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Qnity Electronics', 'workday', 'https://careers.qnityelectronics.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Qnity Electronics');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Qualcomm', 'workday', 'https://careers.qualcomm.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Qualcomm');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Quanta Services', 'workday', 'https://www.quantaservices.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Quanta Services');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Raymond James', 'workday', 'https://jobs.raymondjames.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Raymond James');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Realty Income', 'workday', 'https://www.realtyincome.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Realty Income');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Regeneron', 'workday', 'https://careers.regeneron.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Regeneron');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'RELX', 'workday', 'https://www.relx.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'RELX');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Republic Services', 'workday', 'https://careers.republicservices.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Republic Services');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'ResMed', 'workday', 'https://jobs.resmed.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'ResMed');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Restaurant Brands Intl', 'workday', 'https://careers.rbi.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Restaurant Brands Intl');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rio Tinto', 'workday', 'https://careers.riotinto.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rio Tinto');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rocket Companies', 'workday', 'https://careers.rocket.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rocket Companies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rocket Lab', 'workday', 'https://www.rocketlabusa.com/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rocket Lab');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Rockwell Automation', 'workday', 'https://careers.rockwellautomation.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Rockwell Automation');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Roper Technologies', 'workday', 'https://roper.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Roper Technologies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ross Stores', 'workday', 'https://jobs.rossstores.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ross Stores');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Royal Bank of Canada', 'workday', 'https://jobs.rbc.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Royal Bank of Canada');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Royal Caribbean', 'workday', 'https://careers.royalcaribbeangroup.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Royal Caribbean');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Royalty Pharma', 'workday', 'https://www.royaltypharma.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Royalty Pharma');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'RTX', 'workday', 'https://careers.rtx.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'RTX');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'S&P Global', 'workday', 'https://careers.spglobal.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'S&P Global');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sanofi', 'workday', 'https://sanofi.com/en/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sanofi');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Seagate', 'workday', 'https://jobs.seagate.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Seagate');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sempra', 'workday', 'https://jobs.sempra.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sempra');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Shell', 'workday', 'https://www.shell.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Shell');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sherwin-Williams', 'workday', 'https://careers.sherwin-williams.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sherwin-Williams');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Simon Property', 'workday', 'https://www.simon.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Simon Property');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'SLB (Schlumberger)', 'workday', 'https://careers.slb.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'SLB (Schlumberger)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Snowflake', 'workday', 'https://careers.snowflake.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Snowflake');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Southern Company', 'workday', 'https://careers.southerncompany.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Southern Company');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Starbucks', 'workday', 'https://careers.starbucks.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Starbucks');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'State Street', 'workday', 'https://careers.statestreet.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'State Street');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Steel Dynamics', 'workday', 'https://www.steeldynamics.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Steel Dynamics');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sterling Infrastructure', 'workday', 'https://sterlingrsg.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sterling Infrastructure');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'STMicroelectronics', 'workday', 'https://www.st.com/content/st_com/en/about/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'STMicroelectronics');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Strategy (MicroStrategy)', 'workday', 'https://www.microstrategy.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Strategy (MicroStrategy)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Stryker', 'workday', 'https://careers.stryker.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Stryker');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sun Life Financial', 'workday', 'https://sunlife.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sun Life Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sunbelt Rentals', 'workday', 'https://careers.sunbeltrentals.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sunbelt Rentals');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Suncor Energy', 'workday', 'https://careers.suncor.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Suncor Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Super Micro Computer', 'workday', 'https://careers.supermicro.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Super Micro Computer');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Synopsys', 'workday', 'https://www.synopsys.com/company/job-search.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Synopsys');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sysco', 'workday', 'https://jobs.sysco.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sysco');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'T-Mobile', 'workday', 'https://careers.t-mobile.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'T-Mobile');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Take-Two Interactive', 'workday', 'https://careers.take2games.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Take-Two Interactive');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Takeda', 'workday', 'https://www.takeda.com/en-us/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Takeda');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Tapestry', 'workday', 'https://careers.tapestry.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Tapestry');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Targa Resources', 'workday', 'https://careers.targaresources.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Targa Resources');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Target', 'workday', 'https://corporate.target.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Target');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TC Energy', 'workday', 'https://careers.tcenergy.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TC Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TE Connectivity', 'workday', 'https://jobs.te.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TE Connectivity');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TechnipFMC', 'workday', 'https://www.technipfmc.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TechnipFMC');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Teck Resources', 'workday', 'https://jobs.teck.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Teck Resources');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Teledyne', 'workday', 'https://www.teledyne.com/en-us/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Teledyne');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Teradyne', 'workday', 'https://jobs.teradyne.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Teradyne');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Teva Pharma', 'workday', 'https://careers.teva', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Teva Pharma');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Texas Pacific Land', 'workday', 'https://texaspacific.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Texas Pacific Land');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Thermo Fisher', 'workday', 'https://jobs.thermofisher.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Thermo Fisher');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Thomson Reuters', 'workday', 'https://careers.thomsonreuters.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Thomson Reuters');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TJX Companies', 'workday', 'https://careers.tjx.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TJX Companies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TKO Group', 'workday', 'https://tkogroupholdings.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TKO Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Toronto-Dominion', 'workday', 'https://jobs.td.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Toronto-Dominion');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TotalEnergies', 'workday', 'https://careers.totalenergies.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TotalEnergies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Trane Technologies', 'workday', 'https://careers.tranetechnologies.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Trane Technologies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'TransDigm', 'workday', 'https://www.transdigm.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'TransDigm');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Travelers', 'workday', 'https://careers.travelers.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Travelers');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Truist Financial', 'workday', 'https://careers.truist.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Truist Financial');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'U.S. Bancorp', 'workday', 'https://careers.usbank.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'U.S. Bancorp');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ubiquiti', 'workday', 'https://www.ui.com/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ubiquiti');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'UBS Group', 'workday', 'https://www.ubs.com/global/en/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'UBS Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Unilever', 'workday', 'https://careers.unilever.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Unilever');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Union Pacific', 'workday', 'https://up.jobs', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Union Pacific');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'United Airlines', 'workday', 'https://careers.united.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'United Airlines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'United Rentals', 'workday', 'https://jobs.ur.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'United Rentals');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'UnitedHealth (Optum)', 'workday', 'https://careers.unitedhealthgroup.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'UnitedHealth (Optum)');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'UPS', 'workday', 'https://www.jobs-ups.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'UPS');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Valero Energy', 'workday', 'https://careers.valero.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Valero Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Ventas', 'workday', 'https://www.ventasreit.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Ventas');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Venture Global', 'workday', 'https://ventureglobal.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Venture Global');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'VeriSign', 'workday', 'https://www.verisign.com/en_US/company-information/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'VeriSign');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Verizon', 'workday', 'https://mycareer.verizon.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Verizon');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Vertex Pharma', 'workday', 'https://www.vrtx.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Vertex Pharma');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'VICI Properties', 'workday', 'https://viciproperties.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'VICI Properties');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Viking Holdings', 'workday', 'https://www.vikingcruises.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Viking Holdings');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Vistra', 'workday', 'https://vistra.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Vistra');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Vodafone', 'workday', 'https://careers.vodafone.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Vodafone');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Vulcan Materials', 'workday', 'https://www.vulcanmaterials.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Vulcan Materials');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'W.W. Grainger', 'workday', 'https://jobs.grainger.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'W.W. Grainger');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Wabtec', 'workday', 'https://careers.wabtec.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Wabtec');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Walmart', 'workday', 'https://careers.walmart.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Walmart');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Walt Disney', 'workday', 'https://jobs.disneycareers.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Walt Disney');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Warner Bros Discovery', 'workday', 'https://careers.wbd.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Warner Bros Discovery');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Waste Connections', 'workday', 'https://careers.wasteconnections.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Waste Connections');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Waste Management', 'workday', 'https://careers.wm.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Waste Management');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Waters', 'workday', 'https://careers.waters.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Waters');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'WEC Energy', 'workday', 'https://careers.wecenergygroup.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'WEC Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Wells Fargo', 'workday', 'https://www.wellsfargo.com/about/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Wells Fargo');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Welltower', 'workday', 'https://welltower.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Welltower');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Western Digital', 'workday', 'https://www.westerndigital.com/company/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Western Digital');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Wheaton Precious Metals', 'workday', 'https://www.wheatonpm.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Wheaton Precious Metals');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Williams Companies', 'workday', 'https://careers.williams.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Williams Companies');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Woodside Energy', 'workday', 'https://www.woodside.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Woodside Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Workday', 'workday', 'https://www.workday.com/en-us/company/careers.html', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Workday');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Xcel Energy', 'workday', 'https://www.xcelenergy.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Xcel Energy');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Yum! Brands', 'workday', 'https://careers.yum.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Yum! Brands');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Zoetis', 'workday', 'https://careers.zoetis.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Zoetis');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Zoom', 'workday', 'https://careers.zoom.us', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Zoom');

-- -------------------------------------------------------
-- GREENHOUSE
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Airbnb', 'greenhouse', 'https://careers.airbnb.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Airbnb');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AppLovin', 'greenhouse', 'https://www.applovin.com/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AppLovin');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'AST SpaceMobile', 'greenhouse', 'https://ast-science.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'AST SpaceMobile');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Astera Labs', 'greenhouse', 'https://www.asteralabs.com/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Astera Labs');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Axon Enterprise', 'greenhouse', 'https://www.axon.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Axon Enterprise');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cerebras Systems', 'greenhouse', 'https://www.cerebras.ai/join-us', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cerebras Systems');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Cloudflare', 'greenhouse', 'https://careers.cloudflare.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Cloudflare');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coinbase', 'greenhouse', 'https://www.coinbase.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coinbase');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CoreWeave', 'greenhouse', 'https://coreweave.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CoreWeave');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Coupang', 'greenhouse', 'https://www.coupang.jobs', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Coupang');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Credo Technology', 'greenhouse', 'https://www.credosemi.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Credo Technology');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Datadog', 'greenhouse', 'https://careers.datadoghq.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Datadog');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MongoDB', 'greenhouse', 'https://www.mongodb.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MongoDB');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Nebius Group', 'greenhouse', 'https://nebius.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Nebius Group');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Reddit', 'greenhouse', 'https://www.redditinc.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Reddit');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Revolution Medicines', 'greenhouse', 'https://www.revmed.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Revolution Medicines');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Robinhood', 'greenhouse', 'https://careers.robinhood.com/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Robinhood');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Roblox', 'greenhouse', 'https://careers.roblox.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Roblox');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Sea Limited', 'greenhouse', 'https://careers.sea.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Sea Limited');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Spotify', 'greenhouse', 'https://jobs.spotify.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Spotify');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Symbotic', 'greenhouse', 'https://www.symbotic.com/careers', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Symbotic');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Twilio', 'greenhouse', 'https://www.twilio.com/en-us/company/jobs', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Twilio');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Uber', 'greenhouse', 'https://www.uber.com/us/en/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Uber');

-- -------------------------------------------------------
-- LEVER
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Palantir', 'lever', 'https://www.palantir.com/careers/', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Palantir');

-- -------------------------------------------------------
-- SMARTRECRUITERS
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'SanDisk', 'smartrecruiters', 'https://www.sandisk.com/careers/jobs-at-sandisk', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'SanDisk');

INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Visa', 'smartrecruiters', 'https://careers.visa.com', '{}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Visa');

-- -------------------------------------------------------
-- EIGHTFOLD
-- -------------------------------------------------------
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'MercadoLibre', 'eightfold', 'https://careers-meli.mercadolibre.com/en', '{"careers_url":"https://careers-meli.mercadolibre.com/en"}'::jsonb, true
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'MercadoLibre');

-- -------------------------------------------------------
-- iCIMS (slug needs manual lookup per company)
-- -------------------------------------------------------
-- TODO: find iCIMS domain for Costco
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Costco', 'icims', 'https://careers.costco.com', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Costco');

-- TODO: find iCIMS domain for CVS Health
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'CVS Health', 'icims', 'https://jobs.cvshealth.com', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'CVS Health');

-- TODO: find iCIMS domain for Home Depot
INSERT INTO companies (company_name, ats, career_url, ats_config, active)
SELECT 'Home Depot', 'icims', 'https://careers.homedepot.com', '{}'::jsonb, false
WHERE NOT EXISTS (SELECT 1 FROM companies WHERE company_name = 'Home Depot');

-- -------------------------------------------------------
-- SKIPPED (no scraper yet):
--   Alibaba                                  [custom]  https://career.alibaba.com
--   Alphabet (Google)                        [custom]  https://careers.google.com
--   Amazon                                   [custom]  https://amazon.jobs
--   America Movil                            [custom]  https://careers.americamovil.com
--   Amrize                                   [SuccessFactors]  https://www.amrize.com/us/en/careers.html
--   Apple                                    [custom]  https://jobs.apple.com
--   ASE Technology                           [custom]  https://esg.aseglobal.com/en/career
--   Baidu                                    [custom]  https://talent.baidu.com/external/baidu/index.html
--   Banco Bradesco                           [custom]  https://banco.bradesco/html/pessoajuridica/trabalhenos/
--   Banco Santander                          [SuccessFactors]  https://jobs.santander.com/en
--   BBVA                                     [custom]  https://careers.bbva.com
--   Boeing                                   [Taleo]  https://jobs.boeing.com
--   Chunghwa Telecom                         [custom]  https://www.cht.com.tw/en/home/cht/career
--   Ecopetrol                                [custom]  https://www.ecopetrol.com.co/wps/portal/Home/es/Empleo-y-practicas/
--   Elbit Systems                            [custom]  https://elbitsystems.com/careers
--   Eni                                      [custom]  https://www.eni.com/en-IT/careers.html
--   Exxon Mobil                              [SuccessFactors]  https://jobs.exxonmobil.com/
--   FEMSA                                    [custom]  https://jobs.femsa.com
--   Ferrari                                  [custom]  https://corporate.ferrari.com/en/careers
--   Ferrovial                                [custom]  https://www.ferrovial.com/en/talent/
--   HDFC Bank                                [custom]  https://www.hdfcbank.com/personal/resources/careers
--   Honda Motor                              [custom]  https://www.honda-jobs.com
--   ICICI Bank                               [custom]  https://www.icicicareers.com
--   Infosys                                  [custom]  https://www.infosys.com/careers/
--   Itau Unibanco                            [custom]  https://itauvaga.com.br
--   JD.com                                   [custom]  https://careers.jd.com
--   KB Financial                             [custom]  https://www.kbfg.com/Eng/careers/
--   Meta                                     [custom]  https://www.metacareers.com
--   Microsoft                                [custom]  https://careers.microsoft.com
--   Mitsubishi UFJ                           [custom]  https://www.mufg.jp/english/careers/
--   Mizuho                                   [custom]  https://careers.mizuhogroup.com
--   NetEase                                  [custom]  https://hr.netease.com
--   Nu Holdings                              [custom]  https://nubank.com.br/en/careers
--   Oracle                                   [Oracle Recruiting Cloud]  https://www.oracle.com/careers/
--   ORIX                                     [custom]  https://www.orix.com/careers
--   PDD Holdings                             [custom]  https://careers.pddholdings.com
--   Petrobras                                [custom]  https://portal.petrobras.com.br/en/people-and-careers
--   Petrobras (A)                            [custom]  https://portal.petrobras.com.br/en/people-and-careers
--   Prudential plc                           [custom]  https://jobs.prudentialplc.com
--   Ryanair                                  [custom]  https://careers.ryanair.com
--   Shinhan Financial                        [custom]  https://www.shinhangroup.com/en/company/recruit.jsp
--   Sony Group                               [custom]  https://www.sony.com/en/SonyInfo/Jobs/
--   Southern Copper                          [custom]  https://southerncopper.com/careers
--   Sumitomo Mitsui                          [custom]  https://www.smfg.co.jp/english/recruit/
--   Tenaris                                  [custom]  https://www.tenaris.com/en/company/people/
--   Texas Instruments                        [custom]  https://careers.ti.com
--   Tower Semiconductor                      [custom]  https://www.towersemi.com/careers/
--   Toyota (N.A.)                            [custom]  https://www.toyota.com/careers
--   Trip.com                                 [custom]  https://careers.trip.com
--   TSMC                                     [custom]  https://careers.tsmc.com
--   United Microelectronics                  [custom]  https://www.umc.com/en/careers
--   Vale                                     [custom]  https://www.vale.com/en/careers
--   Veeva Systems                            [custom]  https://jobs.veeva.com
--   Vertiv                                   [Oracle Recruiting Cloud]  https://www.vertiv.com/en-us/about/career-center/