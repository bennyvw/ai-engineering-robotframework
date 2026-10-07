*** Settings ***
Documentation       Search form on the products page (spec: shop/search).

Resource            resources/search.resource

Suite Setup         Open Shop Browser
Suite Teardown      Close Browser
Test Setup          Start Shop Test

Test Tags           WEB-004    ui


*** Test Cases ***
WEB-004_AC-2 Search Input Is Visible On Products Page
    [Documentation]    The /products page shows a visible search input.
    Search Input Should Be Visible On Products Page