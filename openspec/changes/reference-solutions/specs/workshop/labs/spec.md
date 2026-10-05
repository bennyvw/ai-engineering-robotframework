## MODIFIED Requirements

### Requirement: Labs do not give the answers away
Participant-facing material on `main` SHALL NOT name the planted defects, the suite's inline locator, or the cause of a test broken on purpose. It MAY say where to look. The reference pages and transcripts on the `solutions` branch show these answers by design. A lab MAY link them, and SHALL NOT quote them.

#### Scenario: Reading Lab 7
- **WHEN** a participant reads Lab 7's instructions before running the suite under `buggy`
- **THEN** they learn how to find and file a defect, but not which defects exist

#### Scenario: Following a reference link
- **WHEN** a participant opens Lab 4's reference page on the site
- **THEN** it explains the cause of the Module 4 broken test, while no file on `main` states it
