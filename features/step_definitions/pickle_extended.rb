Given /^campaigns for current user exist$/ do
  Factory(:campaign, :user_id => @current_user.id, :title => "First campaign")
  Factory(:campaign, :user_id => @current_user.id, :title => "Second campaign")
end

Given /^all roles exist$/ do
	Role.create!(:name => "admin");
	Role.create!(:name => "writer");
	Role.create!(:name => "blogger");
	Role.create!(:name => "company");
end

Given /^some campaigns exist in system$/ do
  @user = Factory(:user, :email => "company@doe.com", :name => "Chilly")
  Factory(:campaign, :user_id => @user.id, :title => "First campaign")
  Factory(:campaign, :user_id => @user.id, :title => "Second campaign")
  Factory(:campaign, :user_id => @user.id, :title => "Third campaign")
end

Given /^some campaigns with articles exist in system$/ do
  @campaign = Factory(:campaign, :user_id => @current_user.id, :title => "Awesome job")
  Factory(:article, :campaign => @campaign, :title => "Ruby on Rails")
end

