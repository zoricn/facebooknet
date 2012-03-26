source "http://rubygems.org"

gem 'rails', '3.2.1'
gem 'sprockets', '~> 2.0'
gem "mysql2"

gem 'json'
gem 'coffee-script'

gem "devise", "~> 1.4.6"
gem "oa-oauth", :require => "omniauth/oauth"
gem "jquery-rails", "~> 1.0.9"


group :test, :development do
  gem "rspec-rails", "~> 2.4"
  gem "email_spec"
  gem "shoulda"
	gem 'spork', '~> 0.9.0.rc9'
  gem "cucumber-rails"
  gem "capybara"
  gem "factory_girl_rails"
  gem "database_cleaner"
  gem "ruby-debug19"
  gem "mongrel", ">= 1.2.0.pre2"
  gem "chronic"
  gem "awesome_print"
  gem "therubyracer"
end

group :assets do  
  gem 'sass-rails',   '~> 3.2.3'  
  gem 'coffee-rails', '~> 3.2.1'  
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes  
  # gem 'therubyracer'  
  gem 'uglifier', '>= 1.0.3'  
end 

#bundle install --path vendor/bundle --without production for use on heroku
group :production do
  gem "therubyracer-heroku"
  gem "pg", :require => "pg"
end

gem "koala" #Facebook wrapper
