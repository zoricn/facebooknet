

Given /^I am registered$/ do
  @registered_user = Factory(:user, :email => "john@doe.com")
end

Given /^I am logged in$/ do
  @current_user = Factory(:user, :email => "john@doe.com")
end

Given /^I am admin$/ do
  @registered_user.make_admin
end

Given /^I am regular$/ do
  @current_user.make_regular
end


Given /^the user is logged in$/ do
  #FbService.stub!(:fb_logout_url).and_return(dashboard_path)
  @current_user = Factory(:user, :email => "john@doe.com")
  @current_user.make_regular
  omniauth_mock_facebook
  visit "/users/auth/facebook"
end

Given /^I am logged in$/ do
  @current_user = Factory(:user, :email => "john@doe.com")
  @current_user.make_regular
  omniauth_mock_facebook
  visit "/users/auth/facebook"
end

