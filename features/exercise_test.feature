Feature: SignatureIt Exercise
  As a candidate
  I want to test the login form from the app
  So the team could evaluate my work


  Scenario: Open the main Page
    Given I open the main page
    And  I see the registration link
    When I click registration link
    Then I see the registration form
    Then I submit empty form
    Then I verify all field errors are correct