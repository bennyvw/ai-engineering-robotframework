*** Settings ***
Documentation       Search workflows on the home and products pages (spec: shop/search).

Resource            resources/search.resource

Suite Setup         Open Shop Browser
Suite Teardown      Close Browser
Test Setup          Start Shop Test

Test Tags           WEB-004    ui


*** Test Cases ***
WEB-004_AC-1 Search Input Is Visible On Home Page
    [Documentation]    The home page hero shows a purpose-labelled search input.
    Search Input Should Be Visible On Home Page

WEB-004_AC-3 Search Shows Matching Product Card
    [Documentation]    Submitting "headphones" shows Aurora Neural Headphones with name, image, and price.
    Search Home Page For    headphones
    Search Results Should Show Aurora Neural Headphones

WEB-004_AC-6 Clear Results On Home Page
    [Documentation]    Clearing home-page results restores the hero and empties the search input.
    Search Home Page For    headphones
    Search Results Should Show Aurora Neural Headphones
    Clear Home Page Search Results

WEB-004_AC-6 Clear Search On Products Page
    [Documentation]    Clearing products-page results restores the product grid and empties the search input.
    Search Products Page For    headphones
    Search Results Should Show Aurora Neural Headphones
    Clear Products Page Search Results

WEB-004_AC-7 Empty State When Search Has No Matches
    [Documentation]    Searching for "xyz123" displays the no-products-found message.
    Search Home Page With No Matches    xyz123
