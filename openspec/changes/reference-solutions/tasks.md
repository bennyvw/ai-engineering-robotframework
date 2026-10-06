## 1. Prepare the solutions branch

- [x] 1.1 Rebase `solutions` onto `main` (design D2). Verify:
  - `git log --oneline main..solutions` lists the seven lab commits in lab order, each message starting with its lab's folder name;
  - on `solutions`, the whole suite passes against a freshly reset shop, including the two tests repaired in Labs 4 and 5.
- [x] 1.2 Write the reference pages under `solutions/`: an index, and one page per lab for Labs 0 and 2 to 9 (design D6). Verify:
  - every page has the four parts of the specification;
  - every file shown in full matches the file in its lab's commit;
  - the transcript scan finds no secret, local path, user or host name in the pages.
- [x] 1.3 Commit the pages as a `reference` commit that also drops the `.gitignore` lines of design D5, and push the branch as `solutions-next` for review. Force-push it to `solutions` once the pages are approved. Verify:
  - `git log --oneline main..origin/solutions` shows the lab commits, then the reference commit;
  - Lab 5's catch-up command still restores `AGENTS.md` from the branch.

## 2. The site

- [x] 2.1 Change `docs-site.yml`, `docusaurus.config.js`, `sidebars.js` and `website/package.json` (design D3):
  - the build takes the reference material from the right ref for each event;
  - deployment runs for pushes to `main` and to `solutions`, in one concurrency group;
  - the sidebar gets a *Solutions* category;
  - `package.json` gets a `reference` script for local builds.

  Verify:
  - `actionlint` passes;
  - every `uses:` line is pinned to a SHA with a release comment, and every job keeps the repository guard;
  - after `npm run reference`, a local build passes with *Solutions*, *Transcripts* and the facilitator pages in the sidebar;
  - `git status` shows none of the added files.

## 3. Links and tools on main

- [x] 3.1 Point every lab's "If your agent fails" link to its transcript on the site, and add a *Compare with the reference* section after *Stretch* (design D4). Update `labs/README.md`, the run sheet, `README.md`, `CONTRIBUTING.md`, and the triage playbook (the branch on GitHub, if the site is down). Verify:
  - `git diff` shows no change to any lab's steps, stretch goal or checklist;
  - `tools/check_labs.py` passes.
- [x] 3.2 Extend `tools/check_labs.py` (design D4, D5):
  - transcript and reference links checked against the `solutions` branch;
  - patterns stored encoded, with `--show-patterns`;
  - a scan of every tracked file on `main`, with the exemptions of design D5.

  Verify:
  - on `main` before the move, the scan reports the known answer-bearing files and exits non-zero;
  - `--show-patterns` prints the patterns;
  - `git grep` finds no decoded cause in `tools/check_labs.py`;
  - a sentence stating a planted defect, added to a scratch copy, is reported.
- [x] 3.3 Make `tools/verify_outcomes.py` read its data from `origin/solutions` by default (design D7). Verify:
  - from `main`, `--preset clean` passes against the branch's data;
  - in a scratch clone without the branch, it prints the command that fetches it.
- [x] 3.4 Replace each stated cause in the archived `baseline-suite` design and tasks with a pointer to the answer sheet (design D5). Verify:
  - the all-of-`main` scan finds nothing in them;
  - each changed sentence still says what was decided.

## 4. The move

- [x] 4.1 Delete `transcripts/` and `docs/facilitator/suite-outcomes.md` and `.toml` from `main`, and add their paths to `.gitignore` (design D1, D5). Verify:
  - the all-of-`main` scan finds nothing;
  - `git grep` for the name of each test broken on purpose prints no cause;
  - the pull request's site build, using the material from `origin/solutions`, passes.
- [x] 4.2 After the merge, rebase `solutions` onto `main`. The reference commit adds back the transcripts and the answer sheet as they stood before 4.1 (design, migration step 3). Verify:
  - the restored files are identical to their last version on `main`;
  - the suite on `solutions` passes;
  - after the redeployment, each lab's transcript and reference URL answers with HTTP 200, as do the facilitator pages.

## 5. Close-out

- [x] 5.1 Run the checks. Verify:
  - `openspec validate --all --strict` passes;
  - `tools/check_labs.py` passes, including the all-of-`main` scan;
  - `tools/verify_outcomes.py` passes from `main`;
  - the site build passes;
  - the transcript scan on the `solutions` branch finds no secret or local path.
  - a push to `solutions` builds, then redeploys the site from `main` (design D3), and the deployment succeeds.
- [ ] 5.2 Archive after the merge. Verify:
  - `workshop/solutions` gains *Reference pages* and *No answers on main*, and its *A solutions branch* names the reference commits;
  - the changed requirements of `workshop/facilitation`, `workshop/docs-site`, `workshop/baseline-suite` and `workshop/labs` read as in the change.
