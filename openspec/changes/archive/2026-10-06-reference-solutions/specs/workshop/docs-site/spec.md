## MODIFIED Requirements

### Requirement: One source
The site SHALL render, each from where it lives and without committed copies, generated duplicates or front matter added to them:
- from `main`: `README.md`, `SETUP.md`, `GLOSSARY.md` and the Markdown files under `labs/` and `docs/`;
- from the `solutions` branch: the Markdown files under `transcripts/` and `solutions/`, and the facilitators' answer sheet.

The build SHALL take the branch's files into its own workspace only. `README.md` SHALL be the site's home page.

#### Scenario: A lab is edited
- **WHEN** a lab's `INSTRUCTIONS.md` is changed on `main`
- **THEN** the next deployment of the site shows the change, and no other file needed editing

#### Scenario: A transcript is edited
- **WHEN** a transcript is changed on the `solutions` branch
- **THEN** the next deployment of the site shows the change, and nothing on `main` changed

### Requirement: Deployed from the workshop's repository only
The site SHALL be deployed to GitHub Pages only from the workshop's repository, whenever `main` or the `solutions` branch changes, and always from `main` together with the `solutions` branch. It SHALL be built without deploying for pull requests to either branch. Forks SHALL neither build nor deploy it.

#### Scenario: A fork enables Actions
- **WHEN** a participant's fork runs its workflows
- **THEN** no site job runs there

#### Scenario: A reference page is pushed
- **WHEN** a reference page changes on the `solutions` branch of the workshop's repository
- **THEN** the site is built from `main` and the branch, and deployed
