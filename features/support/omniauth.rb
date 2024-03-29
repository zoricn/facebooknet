FACEBOOK_INFO = {
  "id" => "12345",
  "link" => "http://facebook.com/john_doe",
  "email" => "user@example.com",
  "name" => "John Doe",
  "first_name" => "John",
  "last_name" => "Doe",
  "website" => "http://www.example.com",
  "birthday" => "07/27/1980"
}

Before("@omniauth_test") do
  OmniAuth.config.test_mode = true

  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:facebook] = {
      "uid" => "12345",
      "provider" => "facebook",
      "user_info" => { "nickname" => "Johny" },
      "credentials" => { "token" => "exampletoken" },
      "extra" => { "user_hash" => FACEBOOK_INFO }
  }
end

After("@omniauth_test") do
  OmniAuth.config.test_mode = false
end


def omniauth_mock_facebook
  OmniAuth.config.test_mode = true
  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:facebook] = {
      "uid" => "12345",
      "provider" => "facebook",
      "user_info" => { "nickname" => "Johny", "name" => "John"},
      "credentials" => { "token" => "AAACZBzQ8xMpwBAD5Ud2ZAxOXyWGvPZBKe8mDuKEOFcFu9DOmEYEN8KSGqUPvJ55cz5pt9wyAbfBSP7aBhZCWZCmERvfxoMMYIgjSqUTYVeAZDZD" },
      "extra" => { "user_hash" => FACEBOOK_INFO }
  }
end
