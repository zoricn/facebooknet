Feature: Authenticating users

  In order to use the website
  As a user
  I should be able to sign up & sign in

@omniauth_test
  Scenario: Sign in thru Facebook
    Given I am on the homepage
    And I follow "Login"
    Then I should see "Successfully authorized from Facebook account."
