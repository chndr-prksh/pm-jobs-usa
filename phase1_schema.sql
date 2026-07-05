-- ============================================================
-- PHASE 1: Resume-matching & application system schema
-- Run in Supabase SQL editor. Idempotent — safe to re-run.
-- ============================================================

-- -------------------------------------------------------
-- Storage bucket for resume files (base + tailored versions)
-- -------------------------------------------------------
INSERT INTO storage.buckets (id, name, public)
VALUES ('resumes', 'resumes', false)
ON CONFLICT (id) DO NOTHING;

-- -------------------------------------------------------
-- candidate_profile — your parsed base info (singleton row)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS candidate_profile (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name         text,
    email             text,
    phone             text,
    location          text,
    linkedin_url      text,
    portfolio_url     text,
    current_title     text,
    years_experience  numeric,
    summary           text,
    skills            jsonb DEFAULT '[]'::jsonb,      -- ["Product Strategy", "SQL", ...]
    work_history      jsonb DEFAULT '[]'::jsonb,      -- [{company, title, start_date, end_date, description}]
    education         jsonb DEFAULT '[]'::jsonb,      -- [{school, degree, field, start_date, end_date}]
    created_at        timestamp without time zone DEFAULT now(),
    updated_at        timestamp without time zone DEFAULT now()
);

-- -------------------------------------------------------
-- resumes — your base resume file(s)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS resumes (
    id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    version_label  text NOT NULL,          -- e.g. "base", "base-2026-07"
    file_url       text NOT NULL,          -- path within the "resumes" storage bucket
    file_name      text,
    is_base        boolean DEFAULT false,
    created_at     timestamp without time zone DEFAULT now()
);

-- -------------------------------------------------------
-- question_bank — growing key/value store for application questions
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS question_bank (
    id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    question_key   text NOT NULL UNIQUE,   -- normalized slug, e.g. "visa_sponsorship_required"
    question_text  text NOT NULL,          -- raw question text as seen on an application
    answer_value   text,                   -- null until you answer it
    category       text,                   -- e.g. "work_authorization", "compensation", "logistics", "eeo"
    source_company text,                   -- which company's ATS first surfaced this question
    last_updated   timestamp without time zone DEFAULT now(),
    created_at     timestamp without time zone DEFAULT now()
);

-- -------------------------------------------------------
-- resume_versions — per-job tailored resume
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS resume_versions (
    id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    job_id           uuid NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
    base_resume_id   uuid REFERENCES resumes(id),
    file_url         text NOT NULL,        -- path within the "resumes" storage bucket
    tailoring_notes  text,                 -- what Claude changed/emphasized and why
    created_at       timestamp without time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_resume_versions_job_id ON resume_versions(job_id);

-- -------------------------------------------------------
-- job_matches — relevance score + skill gap per job
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS job_matches (
    id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    job_id           uuid NOT NULL UNIQUE REFERENCES jobs(id) ON DELETE CASCADE,
    relevance_score  numeric,              -- e.g. 0-100
    seniority_level  text,                 -- IC / Manager / Senior Manager / Director / VP, inferred from JD
    matched_skills   jsonb DEFAULT '[]'::jsonb,   -- overlap between JD and candidate_profile
    missing_skills   jsonb DEFAULT '[]'::jsonb,   -- gap: JD wants, resume lacks
    reasoning        text,                 -- Claude's explanation
    scored_at        timestamp without time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_job_matches_score ON job_matches(relevance_score DESC);
CREATE INDEX IF NOT EXISTS idx_job_matches_seniority ON job_matches(seniority_level);

-- -------------------------------------------------------
-- applications — tracks what you've actually applied to
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS applications (
    id                 uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    job_id             uuid NOT NULL REFERENCES jobs(id) ON DELETE CASCADE,
    resume_version_id  uuid REFERENCES resume_versions(id),
    status             text NOT NULL DEFAULT 'draft'
                       CHECK (status IN ('draft', 'submitted', 'interviewing', 'rejected', 'offer', 'withdrawn')),
    applied_at         timestamp without time zone,
    notes              text,
    created_at         timestamp without time zone DEFAULT now(),
    updated_at         timestamp without time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_applications_job_id ON applications(job_id);
CREATE INDEX IF NOT EXISTS idx_applications_status ON applications(status);

-- -------------------------------------------------------
-- Added: PM-specific experience, separate from total career years
-- (job postings specify "X years of PM experience", not total career)
-- -------------------------------------------------------
ALTER TABLE candidate_profile ADD COLUMN IF NOT EXISTS pm_years_experience numeric;

-- -------------------------------------------------------
-- Added: test-job flag, so Phase 3+ pipeline testing doesn't
-- burn Claude API tokens against the full jobs table
-- -------------------------------------------------------
ALTER TABLE jobs ADD COLUMN IF NOT EXISTS is_test_job boolean DEFAULT false;
CREATE INDEX IF NOT EXISTS idx_jobs_is_test_job ON jobs(is_test_job) WHERE is_test_job = true;

-- -------------------------------------------------------
-- Added: ats_accounts — non-sensitive metadata for ATS accounts
-- the apply-agent creates. The actual password lives in an
-- Anthropic Vault (environment_variable credential), referenced
-- here by name only — never stored in this table.
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS ats_accounts (
    id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id        uuid NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    ats               text NOT NULL,           -- greenhouse / lever / ashby
    account_email     text NOT NULL,           -- login username, not sensitive
    vault_id          text NOT NULL,           -- which Vault holds the password
    vault_secret_name text NOT NULL,           -- e.g. "GREENHOUSE_ACME_PASSWORD"
    created_at        timestamp without time zone DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ats_accounts_company_id ON ats_accounts(company_id);

-- -------------------------------------------------------
-- Added: applications gains statuses for the review-before-submit
-- flow and the question-answer loop
-- -------------------------------------------------------
ALTER TABLE applications DROP CONSTRAINT IF EXISTS applications_status_check;
ALTER TABLE applications ADD CONSTRAINT applications_status_check
    CHECK (status IN (
        'draft',                 -- resume tailored, not yet started filling
        'pending_review',        -- form filled, screenshot sent to Telegram, awaiting your go-ahead
        'blocked_on_question',   -- hit a question not in question_bank, waiting on your answer
        'submitted',
        'interviewing',
        'rejected',
        'offer',
        'withdrawn'
    ));

-- -------------------------------------------------------
-- Enable RLS on all Phase 1 tables. All access to this schema goes
-- through SUPABASE_DB_URL (direct Postgres connection as the
-- postgres role), which bypasses RLS entirely — this only blocks
-- exposure via Supabase's public anon/authenticated REST API,
-- which nothing in this project uses.
-- -------------------------------------------------------
ALTER TABLE candidate_profile ENABLE ROW LEVEL SECURITY;
ALTER TABLE resumes ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_bank ENABLE ROW LEVEL SECURITY;
ALTER TABLE resume_versions ENABLE ROW LEVEL SECURITY;
ALTER TABLE job_matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE ats_accounts ENABLE ROW LEVEL SECURITY;

-- -------------------------------------------------------
-- Added: applications gains 'blocked_on_verification' for the
-- account-creation email-verification flow (agent creates an ATS
-- account, needs the user to click the verification email link
-- before it can continue filling the form)
-- -------------------------------------------------------
ALTER TABLE applications DROP CONSTRAINT IF EXISTS applications_status_check;
ALTER TABLE applications ADD CONSTRAINT applications_status_check
    CHECK (status IN (
        'draft', 'pending_review', 'blocked_on_question', 'blocked_on_verification',
        'submitted', 'interviewing', 'rejected', 'offer', 'withdrawn'
    ));
