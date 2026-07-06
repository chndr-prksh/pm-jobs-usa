# Apply Copilot Playbook — DOM-first, vision fallback

Operational procedure for driving the **Claude-in-Chrome extension** to fill a
job application in the user's real browser. ATS-agnostic (works on Greenhouse,
Lever, Ashby, Workday, iCIMS, custom portals) because it runs on `read_page` /
`form_input`, which work on any site. Vision (screenshots) is used **only** when
DOM interaction fails — that's the expensive path, so it's the exception.

The answer for every field comes from `field_answers.resolve(label, type, profile)`
— the shared deterministic brain. No per-field AI calls.

## Setup (once per session)
1. `list_connected_browsers` → `select_browser(deviceId)`.
2. `tabs_context_mcp{createIfEmpty:true}` → get the working `tabId`.
3. Load the candidate profile once: `field_answers.load_profile()`.
4. Stage the resume for upload handoff (extension can't inject arbitrary files):
   keep it at `~/Downloads/pm-jobs-usa/base_resume.pdf`.

## Per job
1. `navigate(tabId, url)`.
2. **Reveal the form.** `read_page(filter=interactive)`. If no input fields,
   click the "Apply"/"Apply Now" control, then re-read. (Ashby/Lever/Workday
   land on a description page first.)
3. **Map fields.** From the interactive read, for each field call
   `resolve(label, field_type, profile)`.

4. **Fill — DOM first.** For each field with `confidence == "high"`:
   - `text` / `textarea` / `email` / `tel` → `form_input(ref, value)`.
   - `select` (native) → `form_input(ref, value)` (accepts option text).
   - `combobox` / typeahead (Country, Location) → `form_input(ref, value)`;
     if the value doesn't reflect, fall to vision (step 6).
   - `radio` / `checkbox` (single yes/no) → `form_input(ref, "Yes"/"No")` or
     `form_input(ref, true/false)`.
   - Multi-option radio group → `find` the option whose label == value, then
     `form_input(optionRef, true)`; if unavailable, vision (step 6).

5. **Descriptive fields** (`kind == "descriptive"`): collect them, make ONE
   batched AI draft call (Haiku) using the resume, then `form_input` each.
   Never one AI call per field.

6. **Vision fallback (ONLY when DOM fails).** Triggered when: `form_input`
   didn't reflect the value, the element has no usable ref, a custom widget
   won't take input, or a CAPTCHA/novel screen appears. Then:
   `screenshot` → locate the control/option → `computer.left_click` (coords or
   ref) → re-screenshot to confirm. This is the slow/expensive path — use it
   per-field, not as the default.

7. **Verify.** Re-`read_page`; for any high-confidence field still blank, retry
   once via vision. Take a single screenshot for the final review.

## Always hand to the human (never automate)
- **Resume upload** — extension blocks injecting arbitrary files; user clicks
  Attach and picks the staged resume.
- **CAPTCHA** — never solve/bypass; user solves it (they're present).
- **Account creation / login / email confirmation** — user does it.
- **`kind == "needs_user"`** (salary, start date, novel personal facts) — ask.
- **Final Submit** — user reviews and clicks. Copilot never submits.

## Report per job
Print two lists: **Filled** (field → value) and **Needs you** (resume, any
needs_user fields, CAPTCHA). Then stop and wait.

## Cost / speed note
DOM path: `read_page` + `form_input`, no screenshots → seconds, minimal tokens.
Reserve `screenshot`/`computer` for genuine fallback — it's ~10–20× the tokens.
