ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'database_cleaner'
require 'shoulda/matchers'
require 'support/integration_helper'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  ############ Avdi's database_cleaner setup #############################

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  ##################################################################

  config.include FactoryGirl::Syntax::Methods

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!
end
