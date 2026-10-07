# Design

## Context

See proposal.md for motivation and specs/suite/search/spec.md for the verification contract. `tests/ui/cold_open.robot` already verifies WEB-004_AC-2 using `resources/search.resource`; that resource imports the shared shop-browser keywords. UI tests use a fresh context per test, while selectors belong in resources and should use the shop's accessible, visible contract. The shop itself is supplied as a published image, not maintained in this repository.

## Goals / Non-Goals

**Goals:**
- Cover WEB-004_AC-1, WEB-004_AC-3, WEB-004_AC-6, and WEB-004_AC-7 with criterion-first UI tests.
- Verify clearing on both pages because the story specifies distinct labels and restored content for each.
- Keep tests readable as shopper flows and selectors centralized in the search resource.

**Non-Goals:**
- Change the shop implementation or its existing behavior specifications.
- Add API-level or autocomplete coverage, or duplicate AC-3 and AC-7 checks on both pages.

## Decisions

- Add a focused `tests/ui/search.robot` suite and extend `resources/search.resource`. This keeps the existing cold-open suite focused on AC-2 while grouping the search workflows together; adding these flows to `cold_open.robot` was considered but would mix initial-page checks with search interactions.
- Reuse the Browser Library and the existing shop browser/test lifecycle. Give the new tests the `WEB-004` and `ui` tags and use a fresh test context so results or input state cannot leak between cases.
- Keep test bodies locator-free. Add resource keywords for navigating to the home and products pages, locating and submitting the search field, observing results and normal content, clearing results, and checking the empty state. Build selectors from roles, labels, form scope, and visible text; do not add implementation-specific selectors to the legacy resource.
- Use the shop spec's concrete `headphones` query for AC-3 and `xyz123` for AC-7, both from `/`, submitting with the visible Search button. In the published shop, pressing Enter while autocomplete is open leaves the page in the suggestion state rather than submitting results; the Search button is the other submission method explicitly allowed by AC-3. Test AC-6 separately on `/` and `/products` to verify the revised button labels and each page's restored content. These flows cover the stated scenarios without introducing duplicate route coverage.

## Risks / Trade-offs

- The published shop image may expose markup or accessible names that differ from assumptions made while authoring. Validate the tests against the configured shop and adjust selectors only in `resources/search.resource`, preserving the visible-contract rule.
- Search interactions may include asynchronous updates. Use Browser Library's waiting assertions on visible/hidden states rather than fixed sleeps, so timing remains resilient.

## Migration Plan

No migration is needed. The change is additive: discover and statically analyze the new suite, then run its UI tests against the configured shop.