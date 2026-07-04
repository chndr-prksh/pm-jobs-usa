-- Deactivate companies that fail for reasons automation can't resolve cheaply:
-- Cloudflare bot-blocks GitHub Actions IPs (Uber, MercadoLibre), or the
-- slug genuinely isn't findable via the ATS's public API (wrong ATS label,
-- migrated platform, or renamed board).

UPDATE companies SET active = false WHERE company_name = 'Uber' AND ats = 'uber';
UPDATE companies SET active = false WHERE company_name = 'MercadoLibre' AND ats = 'eightfold';
UPDATE companies SET active = false WHERE company_name = 'Rippling' AND ats = 'rippling';
UPDATE companies SET active = false WHERE company_name = 'Reflektive' AND ats = 'lever';
UPDATE companies SET active = false WHERE company_name = 'Scalapay' AND ats = 'lever';
UPDATE companies SET active = false WHERE company_name = 'Weights & Biases' AND ats = 'lever';
UPDATE companies SET active = false WHERE company_name = 'Statsig' AND ats = 'ashby';
UPDATE companies SET active = false WHERE company_name = 'Cerebras Systems' AND ats = 'greenhouse';
UPDATE companies SET active = false WHERE company_name = 'Credo Technology' AND ats = 'greenhouse';
UPDATE companies SET active = false WHERE company_name = 'Grammarly' AND ats = 'greenhouse';
UPDATE companies SET active = false WHERE company_name = 'Sea Limited' AND ats = 'greenhouse';
UPDATE companies SET active = false WHERE company_name = 'Symbotic' AND ats = 'greenhouse';
