## Context

See proposal.md for why. The facts the design builds on:

- **The `solutions` branch** starts from `main` and adds one commit per lab, for Labs 2 to 8. Labs 0 and 9 produce no files.
  - It is 13 commits behind `main`.
  - Lab 5's catch-up fetches it as `upstream/solutions` and takes `AGENTS.md` from it.
  - A fork copies `main` only, unless its owner unticks *Copy the main branch only*.
- **Answer-bearing files on `main`**, found with `tools/check_labs.py`'s own patterns:
  - `docs/facilitator/suite-outcomes.md` and `.toml`;
  - the archived `baseline-suite` design and tasks;
  - `tools/check_labs.py`;
  - the transcripts of Labs 2, 4, 5 and 7.

  The run sheet, cold-open script, triage playbook and rehearsal record carry none.
- **Links into that material:** every lab links `../../transcripts/<lab>.md`, `labs/README.md` links the transcripts index, and the run sheet names a transcript in text.
- **The tools:** `tools/check_labs.py` requires each lab to link `transcripts/<lab>.md`, and checks links under `labs/`, `docs/` and `transcripts/`. `tools/verify_outcomes.py` reads `docs/facilitator/suite-outcomes.toml` by default.
- **The site:**
  - It renders the repository root with one docs plugin, and its sidebar builds *Transcripts* and *Facilitators* from folders.
  - `docs-site.yml` builds on pull requests and deploys from `main` only, guarded by the repository name.
  - The site uses `trailingSlash: false`, so a page's URL is its path without `.md`: `<site>/transcripts/lab-04-robotcode`.

## Goals / Non-Goals

**Goals:**
- After this change, a participant's clone of their fork contains no answer to any lab, and the site shows everything it shows today, plus a reference page per lab.
- Site URLs of transcripts and facilitator pages stay as they are.
- Nothing a participant does during a lab changes, except where a link points.

**Non-Goals:**
- Hiding answers from someone who deliberately fetches `upstream/solutions` or opens the site.
- Changing the lab results on the branch, apart from the rebase.
- Agent-specific deny rules: they cover one agent, and not `grep`.

## Decisions

### D1. What moves, and what stays

| Material | Today | After |
|---|---|---|
| `transcripts/`: 12 files, including the index, the Lab 8 healing report and the cold open | `main` | `solutions`, same path |
| `docs/facilitator/suite-outcomes.md` and `.toml` | `main` | `solutions`, same path |
| reference pages, one per lab plus an index | none | `solutions`, `solutions/` |
| run sheet, cold-open script, triage playbook, rehearsal record, master preparation | `main` | `main`: they carry no answers |
| archived `baseline-suite` design and tasks | `main`, stating causes | `main`, each cause replaced by a pointer to the answer sheet (D5) |
| `tools/check_labs.py`'s patterns | `main`, in plain text | `main`, encoded (D5) |

Same paths on the branch keep every relative link inside the moved material intact, and keep the site's URLs.

### D2. Layout of the `solutions` branch

```
main ── lab-02-context ── lab-03-skills ── ... ── lab-08-healing ── reference: ...
        (one commit per lab, as today)                              (moved and new material)
```

- **The reference commits go on top**, so each lab commit stays a clean diff of that lab's result. Lab 5's catch-up takes `AGENTS.md` from the branch tip, as before.
- **The first reference commit also removes the `.gitignore` lines** that keep this material off `main` (D5), so maintainers add transcripts on the branch without `-f`.
- **Maintainers change reference material by pull request against `solutions`**, as commits whose messages start with `reference`.

*Alternative:* a separate branch holding only the reference material, with no history shared with `main`. Rejected: it means two branches to explain and to fetch, and "everything that shows an outcome lives on `solutions`" is the rule the user chose.

### D3. The site takes the reference material at build time

The build adds the branch's material to the CI workspace before `npm run build`:

```
git archive <solutions ref> transcripts solutions docs/facilitator/suite-outcomes.md docs/facilitator/suite-outcomes.toml \
  | tar -x
```

- No commit and no index change happens. `.gitignore` on `main` covers these paths in any case.
- `docusaurus.config.js` adds `solutions/**/*.md` to its includes.
- The sidebar gains a *Solutions* category, built from `solutions/` like *Transcripts*.

| Event | Checked out | Reference material from |
|---|---|---|
| push to `main`, *Run workflow* | `main` | `origin/solutions` |
| push to `solutions` | `main`, explicitly | the pushed commit |
| pull request to `main` | the pull request | `origin/solutions` |
| pull request to `solutions` | `main` | the pull request's head |

- Deployment runs from `main` only, and stays guarded by the repository name. The `github-pages` environment allows no other branch, as the first push to `solutions` showed. A push to `solutions` therefore builds, as a check, and then dispatches this workflow on `main`, which deploys. A dispatch started with the workflow's own token is one of the events that does start a new run. The alternative, allowing `solutions` in the environment, would widen a security setting for no gain.
- One concurrency group for deployments keeps a push to `main` and a redeploy for `solutions` from racing.
- A push to `solutions` uses the workflow file from the pushed commit, which is `main`'s after a rebase, because the branch never changes workflows.
- For local builds, `website/package.json` gets a `reference` script that runs the same two commands against `origin/solutions`.

*Alternative:* a second docs plugin pointed at a separate checkout. Rejected: it changes the URLs, and relative links between labs and transcripts would cross two plugin roots.

### D4. Labs link to the site

- **The link format:** the "If your agent fails" link and a new *Compare with the reference* link use absolute site URLs, for example `https://manykarim.github.io/ai-engineering-robotframework/transcripts/lab-04-robotcode`. A relative link would 404 on GitHub's view of `main` and in an editor. Absolute links work in all three places.
- **Where the reference link goes:** a short section *Compare with the reference*, after *Stretch*, saying to open the page once the lab is done.
- **What `check_labs.py` checks:** that each lab links both URLs, and that each URL's path exists as a Markdown file on the `solutions` branch (`git cat-file -e origin/solutions:<path>.md`). `--pending-transcripts` stays for labs not yet recorded.
- **`labs/README.md`** links the transcripts index and the reference index the same way.

### D5. Keeping answers off `main`

- **`.gitignore` on `main`** lists `/transcripts/`, `/solutions/` and `/docs/facilitator/suite-outcomes.*`, so a local site build cannot leak them into a commit.
- **The archived `baseline-suite` design and tasks:** each sentence that states a cause or a planted defect becomes a pointer to the answer sheet on the `solutions` branch. They are history, and the history keeps what was decided, not the answer.
- **`tools/check_labs.py`:**
  - Its patterns are stored base64-encoded and decoded at run time, so the check itself is not a source of answers.
  - It gains a scan of every tracked file on `main`.
  - Exempt are `tests/`, `resources/`, the shop's specifications (current and archived), and lock files, where version numbers match the price-defect pattern.
  - The inline-locator pattern is split. Where the locator is gets checked everywhere. The bare test ID, which every test listing contains, stays a check of participant files only.
- **The participant-file scan** stays as it is.

### D6. The reference pages

Each page is written for a participant who has finished the lab, in the order of the specification:

1. The reference result: key files in full when they are short (`AGENTS.md`, a skill, `.mcp.json`, the hook wiring), otherwise listed with a link to the lab's commit on GitHub. The installed Agent Skills are an example of the second kind.
2. Why it is good, tied to the lab's checklist.
3. The answers to debrief: Lab 4's and Lab 5's causes, Lab 7's planted defects, Lab 8's heals.
4. How to compare, for example `git fetch upstream solutions`, then `git diff upstream/solutions -- AGENTS.md`.

- **Lab 0** shows what a green setup looks like.
- **Lab 9** shows the triage comment and the heal suggestion, from its transcript.
- **The sources** are the branch's lab commits, the transcripts, the rehearsal record and the answer sheet. Nothing new is invented.

### D7. `verify_outcomes.py` reads the data from the branch

- With no `--data`, it reads `docs/facilitator/suite-outcomes.toml` from `origin/solutions` through `git show`.
- When the ref is missing, it exits with the command that fetches it.
- `--data PATH` still overrides.

## Risks / Trade-offs

- **[A rebase force-pushes `solutions`, and open pull requests against it go stale]** → Rebases happen when `main` changes lab-relevant files, and before the workshop tag. A pull request against `solutions` is then rebased by its author.
- **[The site is the only place to read a transcript on the day]** → The branch is readable on GitHub too: `github.com/<repo>/blob/solutions/transcripts/...`. The triage playbook says so.
- **[A participant who ran Lab 5's catch-up has `upstream/solutions` locally]** → An agent reaches it only through deliberate git commands, not through a search of the working tree. Accepted.
- **[Encoded patterns are harder to maintain]** → `tools/check_labs.py --show-patterns` prints them decoded, and a comment says how to add one.
- **[The all-of-`main` scan finds false positives]** → The exemptions of D5. On the migrated `main`, the scan must find nothing before this change counts as done.

## Migration Plan

The site build reads `origin/solutions`, so the branch must hold the material before `main` drops it:

1. **Prepare `solutions`.**
   - Rebase it onto `main`; the suite still passes.
   - Add a reference commit with the `solutions/` pages, and with `.gitignore` adjusted.
   - The transcripts and the answer sheet are still inherited from `main`. Push it with a force-push.
2. **Change `main` by pull request:**
   - delete `transcripts/` and the answer sheet;
   - change `.gitignore`, the lab links, the site build, the tools and the archived `baseline-suite` files.

   Its site build takes the material from `origin/solutions`, which still holds it.
3. **After the merge, rebase `solutions` onto the new `main`.**
   - The inherited transcripts and the answer sheet would disappear with the rebase, so the reference commit now adds them back, as they stood before step 2. Push it with a force-push.
   - The push redeploys the site.
4. **Verify:**
   - the site's transcripts, *Solutions* and facilitator pages;
   - `check_labs.py`'s all-of-`main` scan;
   - the suite on `solutions`;
   - `verify_outcomes.py` from `main`.

**Rollback:** revert the pull request of step 2. The branch keeps the material either way.
