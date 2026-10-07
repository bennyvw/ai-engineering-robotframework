# Spec Delta

## Purpose

Defines the Robot Framework UI suite's verification of the shop's product-search experience, tracing each test to its WEB-004 acceptance criterion.

## ADDED Requirements

### Requirement: Verify WEB-004_AC-1 home-page search
The suite SHALL verify that the home page shows a visible search input in the hero section with a placeholder or label indicating its purpose.

#### Scenario: WEB-004_AC-1 Search input is visible on the home page
- **WHEN** the shopper opens `/`
- **THEN** a search input with a purpose-indicating placeholder or label is visible in the hero section

### Requirement: Verify WEB-004_AC-3 submitted search results
The suite SHALL verify that submitting the query "headphones" from the home page with the Search button displays matching results in a product grid, including Aurora Neural Headphones with its name, image, and price.

#### Scenario: WEB-004_AC-3 Search for headphones
- **WHEN** the shopper opens `/`, enters "headphones" in the search input, and clicks the Search button
- **THEN** the search results section shows Aurora Neural Headphones as a product card with its name, image, and price

### Requirement: Verify WEB-004_AC-6 clearing search results
The suite SHALL verify that clearing active results hides the results, restores the page's normal content, and empties the search input on both the home and products pages.

#### Scenario: WEB-004_AC-6 Clear results on the home page
- **WHEN** search results are displayed on `/` and the shopper clicks "Clear results"
- **THEN** the results are hidden, the hero section is visible again, and the search input is empty

#### Scenario: WEB-004_AC-6 Clear search on the products page
- **WHEN** search results are displayed on `/products` and the shopper clicks "Clear search"
- **THEN** the results are hidden, the normal product grid is visible again, and the search input is empty

### Requirement: Verify WEB-004_AC-7 search empty state
The suite SHALL verify that submitting a query with no matching products from the home page with the Search button displays a visible, user-friendly empty-state message, such as "No results".

#### Scenario: WEB-004_AC-7 Search with no matches
- **WHEN** the shopper opens `/`, enters "xyz123", and clicks the Search button
- **THEN** the visible "No results" message is displayed