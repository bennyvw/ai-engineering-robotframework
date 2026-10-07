---
name: locators-in-resources
description: Checks that Robot Framework tests keep locators in resource keywords and import shared resources from the repository-root Python path, without ${CURDIR} or parent-relative paths. Use when writing or reviewing .robot tests, locators, or Resource imports in this repository.
---

# Locators In Resources

<!--
  Repository convention 2: locators belong in resources, and imports use repository-root paths.
  Apply these repository checks:
    1. Copy this folder into your agent's skill folder and rename it: .claude/skills/<name>/ (Claude Code),
       .agents/skills/<name>/ (Codex) or .github/skills/<name>/ (GitHub Copilot).
    2. Change `name` above to the folder's name.
    3. Rewrite `description`. The agent decides from the description alone whether to load the skill, so say
       what the skill does AND when to use it, with the words a prompt would contain.
    4. Replace the rule, the reason and the examples below with your convention.
  Delete this comment when you are done.
-->

## The rule

Every locator used by a test belongs in a keyword under `resources/`. Tests call those keywords and describe behavior;
they do not contain Browser selectors.

Import shared resources from the repository root, which is on the RobotCode `python-path`: `Resource    resources/shop.resource`.
Never use `${CURDIR}` or parent-relative paths such as `Resource    ../../resources/shop.resource`.

## Why

Centralizing selectors gives page changes one repair location. Repository-root imports resolve from any suite location
because RobotCode adds `.` to `python-path`.

## How to apply it

- When writing a test, look for an existing keyword in `resources/` before adding one.
- Put any new locator inside a keyword in the appropriate resource file; keep test bodies locator-free.
- Import shared resources with repository-root paths such as `resources/shop.resource`.
- Do not use `${CURDIR}` or parent-relative resource paths.
- When reviewing, report locators in test bodies and imports that violate the repository-root path rule.

## Examples

| Import | Verdict |
|---|---|
| `Resource    resources/shop.resource` | use: resolves from the configured repository-root Python path |
| `Resource    ${CURDIR}/../../resources/shop.resource` | avoid: imports must not use `${CURDIR}` |
| `Resource    ../../resources/shop.resource` | avoid: parent-relative traversal |
