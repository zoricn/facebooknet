Then /^I should have '(.+)' friends listed$/ do |friends| x=1
  @friends.count.should == friends
end
