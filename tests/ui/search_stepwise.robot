*** Settings ***
Documentation       Search submission displays matching product cards.
Variables           shop/variables.py
Resource            resources/shop.resource
Resource            resources/search.resource
Suite Setup         Open Shop Browser
Suite Teardown      Close Browser
Test Setup          Start Shop Test
Test Tags           WEB-004    ui


*** Variables ***
${HEADLESS}          ${False}


*** Test Cases ***
WEB-004_AC-3 Search Submission Shows Results
    [Documentation]    Submitting a headphones search displays matching product cards with name, image and price.
    Go To Shop Page    /
    Enter Shop Search Query    headphones
    Submit Shop Search
    Search Results Should Show Aurora Neural Headphones
    Search Result Price Should Be    $249.99
