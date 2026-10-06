## MODIFIED Requirements

### Requirement: A verified expected-outcome matrix
The repository SHALL record, as data on the `solutions` branch, which tests fail under each of the presets `clean`, `stage2`, `stage3`, `stage4`, `buggy` and `drift_and_bug`, and why.

A documented command SHALL:
- read that data from the `solutions` branch by default;
- run the suite under each of these presets against the pinned shop;
- compare the results with the data, and exit with a non-zero status on any difference;
- leave the space reset.

#### Scenario: The image changes behaviour
- **WHEN** a test's outcome under some preset differs from the recorded matrix
- **THEN** the verification command names the test, the preset, and the recorded and actual outcomes, and exits with a non-zero status

#### Scenario: Verifying from main
- **WHEN** a maintainer runs the verification command on a checkout of `main`
- **THEN** it reads the data from the `solutions` branch, or says how to fetch the branch when it is missing
