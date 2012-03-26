Feature: Viewing application's dashboard

  In order to see the dashboard
  As a user
  I should be able to visit the application's dashboard

  Background:
    Given all roles exist
    Given the user is logged in

  @javascript
  Scenario: See the dashboard
    Then I should see "Hello"
