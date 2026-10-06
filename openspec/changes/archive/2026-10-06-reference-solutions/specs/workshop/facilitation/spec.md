## MODIFIED Requirements

### Requirement: Fallback transcripts
The `solutions` branch SHALL contain, under `transcripts/`, one recorded agent walkthrough per lab, taken from the rehearsal runs, so that a participant whose agent fails can follow along. The transcripts SHALL be published on the documentation site, and each lab SHALL link its transcript there. Transcripts SHALL contain no credential, token or API key, and no path or name from the machine they were recorded on.

#### Scenario: A participant's agent fails in Lab 6
- **WHEN** a participant's agent access fails during Lab 6
- **THEN** Lab 6 links its transcript on the site, which shows every prompt and the agent's actions and results

#### Scenario: Scanning the transcripts
- **WHEN** the transcripts are scanned for secrets and local paths
- **THEN** nothing is found
