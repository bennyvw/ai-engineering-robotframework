*** Settings ***
Documentation       Product search controls.

Library             Browser
Resource            shop.resource


*** Keywords ***
Search Input Should Be Visible On Products Page
    Go To Shop Page    /products
    Wait For Elements State    role=searchbox    visible

Search Input Should Be Visible On Home Page
    Go To Shop Page    /
    Wait For Elements State    role=searchbox[name=/search/i]    visible

Enter Shop Search Query
    [Documentation]    Enters a query in the labelled shop search form.
    [Arguments]    ${query}
    Fill Text    role=search >> role=searchbox[name="Search products"]    ${query}

Submit Shop Search
    [Documentation]    Submits the query using the search form's button.
    Click    role=search >> role=button[name="Search"]

Search Result Price Should Be
    [Documentation]    Checks the visible price on a search result card.
    [Arguments]    ${price}
    Wait For Elements State    role=region[name="Search results"] >> role=article >> text="${price}"    visible

Search Home Page For
    [Arguments]    ${query}
    Go To Shop Page    /
    Fill Text    role=searchbox    ${query}
    Click    button:text-is("Search")

Search Products Page For
    [Arguments]    ${query}
    Go To Shop Page    /products
    Fill Text    role=searchbox    ${query}
    Click    button:text-is("Search")

Search Results Should Show Aurora Neural Headphones
    ${card}=    Set Variable    role=region[name="Search results"] >> article:has-text("Aurora Neural Headphones")
    Wait For Elements State    ${card}    visible
    Wait For Elements State    ${card} >> role=heading[name="Aurora Neural Headphones"]    visible
    Wait For Elements State    ${card} >> role=img    visible
    Wait For Elements State    ${card} >> text=/\\$[0-9,]+\\.[0-9]{2}/    visible

Clear Home Page Search Results
    Click    button:has-text("Clear results")
    Wait For Elements State    role=region[name="Search results"]    hidden
    Wait For Elements State    role=heading[level=1]    visible
    Get Property    role=searchbox    value    ==    ${EMPTY}

Clear Products Page Search Results
    Click    button:has-text("Clear search")
    Wait For Elements State    role=region[name="Search results"]    hidden
    Get Element Count    section:has(h2:text-is("All products")):not(:has(section)) >> article    >    0
    Get Property    role=searchbox    value    ==    ${EMPTY}

Search Home Page With No Matches
    [Arguments]    ${query}
    Search Home Page For    ${query}
    Wait For Elements State    text=/no results/i    visible
