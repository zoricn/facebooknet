Given /^all roles exist$/ do
	Role.create!(:name => "admin");
	Role.create!(:name => "regular");
end


