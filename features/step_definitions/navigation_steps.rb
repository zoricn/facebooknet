Given /^Looking at my current user page$/ do
  user = User.find_by_name("John")
  visit user_path(user)
end
