## Why

Participants have no visible way to compare their work with a good result:
- **The `solutions` branch is invisible.** It holds one commit per lab, but no README, lab or site page mentions it. Only Lab 5's catch-up step uses it.
- **It is outdated.** It is 13 commits behind `main`.

Meanwhile the answers the labs ask for are already in every participant's clone, where agents find them while gathering context:
- **A plain search prints causes.** On `main`, a `grep` for the name of Lab 4's broken test prints that test's cause twice, from the archived `baseline-suite` design and tasks.
- **Transcripts show outcomes.** The transcripts of Labs 2, 4, 5 and 7 show a finished `AGENTS.md`, the fixes of both broken tests, and the planted defects.
- **Facilitator and maintainer files name the answers.** `docs/facilitator/suite-outcomes.*` names the causes and which failures are defects. `tools/check_labs.py` spells the causes out as its own patterns.
- **Agents read such files.** The Lab 2 rehearsal's agent read the lab checks and specs before writing anything.

## What Changes

- **One home for everything that shows a lab's outcome: the `solutions` branch.** It holds:
  - the lab results, one commit per lab, as today;
  - a readable reference page per lab;
  - the transcripts;
  - the facilitators' answer sheet (`suite-outcomes`).

  Forks copy `main` only, so none of this reaches a participant's clone.
- **Reference pages, new under `solutions/`**: per lab, the reference result with its key files (for example the reference `AGENTS.md`), why it is good, the answers a facilitator debriefs, and how to compare one's own work.
- **`main` loses its answers**:
  - `transcripts/` and `docs/facilitator/suite-outcomes.md` and `.toml` move to the `solutions` branch, and `.gitignore` keeps them from coming back;
  - the archived `baseline-suite` design and tasks stop stating causes;
  - `tools/check_labs.py` keeps its patterns encoded, and checks every file on `main` for answers.
- **The site renders `main` plus the branch.**
  - The build adds the branch's `transcripts/`, `solutions/` and answer sheet to `main`'s tree in the CI workspace only, so the site is unchanged for readers and gains a *Solutions* section.
  - A push to `solutions` redeploys it.
- **Labs link out**: each lab links its transcript and its reference page on the site, instead of a relative path that no longer exists on `main`.
- **`tools/verify_outcomes.py`** reads the outcome data from the `solutions` branch by default.
- **The `solutions` branch is rebased** onto `main` and still passes its suite.
- **BREAKING for maintainers:** transcripts and the answer sheet are edited on the `solutions` branch, not on `main`.

## Capabilities

### New Capabilities
None.

### Modified Capabilities
- `workshop/solutions`: the branch also holds the reference pages, transcripts and answer sheet; `main` holds no answers anywhere, checked across all its files; participants reach the reference pages from each lab.
- `workshop/facilitation`: transcripts live on the `solutions` branch and are read on the site.
- `workshop/docs-site`: the site renders the `solutions` branch's reference material with `main`, and redeploys when either changes.
- `workshop/baseline-suite`: the expected-outcome data is recorded on the `solutions` branch.
- `workshop/labs`: the rule against giving answers away covers everything on `main`, and exempts the reference pages and transcripts, whose purpose is to show outcomes.

## Impact

- **Moved from `main` to `solutions`:**
  - `transcripts/`: 12 files;
  - `docs/facilitator/suite-outcomes.md` and `.toml`.
- **New on `solutions`:** `solutions/`, one reference page per lab plus an index.
- **Changed on `main`:**
  - the "If your agent fails" link of every lab, plus a reference link per lab;
  - `labs/README.md`, `README.md`, `CONTRIBUTING.md`, `.gitignore`;
  - `.github/workflows/docs-site.yml`, `website/docusaurus.config.js`, `website/sidebars.js`;
  - `tools/check_labs.py`, `tools/verify_outcomes.py`;
  - the archived `baseline-suite` design and tasks.
- **Unchanged:**
  - every lab's steps, checklist and timing;
  - the suite, and its outcomes under every preset;
  - Lab 5's catch-up command;
  - the site's URLs for transcripts and facilitator pages.
- **Order:** the `solutions` branch must hold the moved material before `main` deletes it, because the site build takes it from there. The design gives the sequence.
