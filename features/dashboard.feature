Feature: Viewing application's dashboard

  In order to see the dashboard
  As a user
  I should be able to visit the application's dashboard

  Background:
    Given all roles exist
    Given the user is logged in

  Scenario: See the dashboard
    Then I should see "Your birthday is on: 12/19/1975"
    And I should see "Birthdays of your 2 friends"

  Scenario: User can sign out
    Then I follow "Sign out"
    And I should see "Signed out successfully."

  Scenario: User can't see dashboard when he logs out
    Then I follow "Sign out"
    When I am on the dashboard page
    Then I should see "You must sign in first"

