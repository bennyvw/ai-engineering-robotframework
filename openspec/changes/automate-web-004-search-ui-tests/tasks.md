 # Tasks

## 1. Search UI Coverage

- [x] 1.1 Extend `resources/search.resource` with keywords for the home-page search, results, clear behavior on both pages, and the empty state; verify the keywords are available with `uv run robotcode libdoc resources/search.resource list`.
- [x] 1.2 Add five criterion-first UI tests in `tests/ui/search.robot` for AC-1, AC-3, both AC-6 page variants, and AC-7, using the existing shop lifecycle and `WEB-004`/`ui` tags; verify discovery with `uv run robotcode discover tests --search "WEB-004_AC"`.

## 2. Validation

- [x] 2.1 Run `uv run robotcode analyze code tests/ui/search.robot resources/search.resource` and `uv run robotcode robot --dryrun tests/ui`; verify there are no new static or parse errors.
- [x] 2.2 Run `uv run robotcode robot --exclude broken tests/ui` against the configured shop; verify all five new search tests pass.