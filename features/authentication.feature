Feature: Authenticating users

  In order to use the website
  As a user
  I should be able to sign up & sign in

  Scenario: Sign in thru Facebook
    Given all roles exist
    Given I am on the homepage
    Given the user is logged in
    Then I should see "Successfully authorized from Facebook account."
