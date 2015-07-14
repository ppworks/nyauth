ENV["RAILS_ENV"] ||= 'test'
ENV["NYAUTH_ENCRYPTION_SECRET"] = '1d5deeac604397c58c8ecdfecf1116e1c019a7355f612e67d8d40ac8fbf36b13de1e78dfffeecdf720aa953ab66d23718e21aee4cac5aa7939f34b89d5e6236b'
require 'spec_helper'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/email/rspec'
require 'nyauth/test/controller_macros'
require 'nyauth/test/feature_macros'

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
  config.include Nyauth::Test::ControllerMacros, type: :controller
  config.include Nyauth::Test::FeatureMacros, type: :feature
  config.include EmailSpec::Helpers, type: :mailer
  config.include EmailSpec::Matchers, type: :mailer

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
