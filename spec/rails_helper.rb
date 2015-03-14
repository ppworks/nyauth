ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/email/rspec'
require 'rack_session_access/capybara'

Rails.application.config do
  config.middleware.use RackSessionAccess::Middleware
end

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }
FactoryGirl.definition_file_paths << File.join(ENGINE_RAILS_ROOT, "spec/factories")

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
  config.include ControllerMacros, type: :controller
  config.include FeatureMacros, type: :feature

  config.before(:suite) do
    DatabaseRewinder.clean
    Rails.cache.clear
  end

  config.before(:all) do
    FactoryGirl.reload
  end

  config.after :each do
    DatabaseRewinder.clean
    Rails.cache.clear
  end

  Faker::Config.locale = :en
end
