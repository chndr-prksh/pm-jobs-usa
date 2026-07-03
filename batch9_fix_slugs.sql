-- Fix Greenhouse slug found wrong in first live run
UPDATE companies SET ats_config = '{"slug":"astspacemobile"}'::jsonb
WHERE company_name = 'AST SpaceMobile' AND ats = 'greenhouse';
