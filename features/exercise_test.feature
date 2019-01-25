Feature: Modus Code Exercise
  As a candidate
  I want to tets the budgeting demo app
  So the team could evaluate my work


  Scenario: Open the main Page
    Given I open the main page
    Then  I see the budget tab

  Scenario: Verify Values
    Given I open the main page
    And I see the budget tab
    And I verify that work balance value is correct
    And I verify the total inflow value represents the sum of positive values on table
    And I verify the total outflow value represents the sum of negative values on table
    Then I verify the outflow categories and values from the report page are the same from the outflow on the budget table

  Scenario: Add new items
    Given I open the main page
    And I see the budget tab
    And I delete all items on table
    And I verify that work balance value is correct
    And I verify the total inflow value represents the sum of positive values on table
    And I verify the total outflow value represents the sum of negative values on table
    And I add a new "Income" with "test income description" and "100"
    And I add a new "Groceries" with "test grocery description" and "100"
    And I verify the total inflow value represents the sum of positive values on table
    And I verify the total outflow value represents the sum of negative values on table
    Then I verify the outflow categories and values from the report page are the same from the outflow on the budget table

  Scenario: Add new item with non numeric amount
    Given I open the main page
    And I see the budget tab
    And I delete all items on table
    And I verify that work balance value is correct
    And I verify the total inflow value represents the sum of positive values on table
    And I verify the total outflow value represents the sum of negative values on table
    And I add a new "Income" with "test income description" and "70"
    And I add a new "Groceries" with "test grocery description" and "test"
    And I verify the total inflow value represents the sum of positive values on table
    And I verify the total outflow value represents the sum of negative values on table
    Then I verify the outflow categories and values from the report page are the same from the outflow on the budget table