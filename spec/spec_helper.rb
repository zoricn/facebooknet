# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

	ENV["RAILS_ENV"] ||= 'test'
	require File.expand_path("../../config/environment", __FILE__)
	require 'rspec/rails'
	require 'email_spec'
  require 'factory_girl'

	# Requires supporting ruby files with custom matchers and macros, etc,
	# in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  begin
    Dir[('factories/*.rb')].each {|f| require f } 
  rescue Factory::DuplicateDefinitionError
    nil
  end

	RSpec.configure do |config|
		config.mock_with :rspec
		config.include(EmailSpec::Helpers)
		config.include(EmailSpec::Matchers)

		# Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
		#config.fixture_path = "#{::Rails.root}/spec/fixtures"

		# If you're not using ActiveRecord, or you'd prefer not to run each of your
		# examples within a transaction, remove the following line or assign false
		# instead of true.
		#config.use_transactional_fixtures = true



		config.before(:suite) do
		  DatabaseCleaner.strategy = :transaction
		  DatabaseCleaner.clean_with(:truncation)
		end

		config.before(:each) do
		  DatabaseCleaner.start
		end

		config.after(:each) do
		  DatabaseCleaner.clean
		end

	end

end

Spork.each_run do
  # This code will be run each time you run your specs.
  #Load all factories and report if there is duplicate definition
# reload all the models
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end

  Dir["#{Rails.root}/lib/**/*.rb"].each do |lib|
    load lib
  end

	# reload all the controllers
  Dir["#{Rails.root}/app/controllers/**/*.rb"].each do |controller|
    load controller
  end

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end

#Enable to have coverage tool
#require 'simplecov'
#SimpleCov.start


module UserSpecHelper
  def valid_user_attributes
    {
      :provider => 'facebook',
      :uid => '111111111'
    }
  end

  def valid_omniauth_hash
    {
      "provider" => 'facebook',
      "uid" => '111111111',
      "user_info" => {
        "name" => "Nebojsa Zoric",
        "email" => "testing@test.net"
      },
      "credentials" => {
        "token" => "111111111"
      }
    }
  end
end

module Spec
  module Mocks
    module Methods
      def stub_association!(association_name, methods_to_be_stubbed = {})
        mock_association = Spec::Mocks::Mock.new(association_name.to_s)
        methods_to_be_stubbed.each do |method, return_value|
          mock_association.stub!(method).and_return(return_value)
        end
        self.stub!(association_name).and_return(mock_association)
      end
    end
  end
end
