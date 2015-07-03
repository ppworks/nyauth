require 'rails_helper'
require 'generators/nyauth/install_generator'

describe Nyauth::InstallGenerator, type: :generator do
  destination ::File.expand_path('../tmp/', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  describe 'rails g nyauth:install' do
    it 'creates a test initializer' do
      assert_file 'config/initializers/nyauth.rb', /config.encryption_secret = ENV\['NYAUTH_ENCRYPTION_SECRET'\]/
      assert_file 'config/initializers/nyauth.rb', /config.confirmation_expire_limit = 1.hour/
      assert_file 'config/initializers/nyauth.rb', /config.reset_password_expire_limit = 1.hour/
      assert_file 'config/initializers/nyauth.rb', /config.redirect_path do |urls|/
      assert_file 'config/initializers/nyauth.rb', /# config.redirect_path_after_sign_in = -> \(client_name\) \{\}/
      assert_file 'config/initializers/nyauth.rb', /# config.redirect_path_after_sign_out = -> \(client_name\) \{\}/
      assert_file 'config/initializers/nyauth.rb', /# config.redirect_path_after_registration = -> \(client_name\) \{\}/
      assert_file 'config/initializers/nyauth.rb', /# config.redirect_path_after_create_request_confirmation = -> \(client_name\) \{\}/
      assert_file 'config/initializers/nyauth.rb', /# config.redirect_path_after_update_confirmation = -> \(client_name\) \{\}/
      assert_file 'config/initializers/nyauth.rb', /# config.redirect_path_after_reset_password_request = -> \(client_name\) \{\}/
      assert_file 'config/initializers/nyauth.rb', /# config.redirect_path_after_reset_password = -> \(client_name\) \{\}/
      assert_file 'config/initializers/nyauth.rb', /# config.redirect_path_after_update_password = -> \(client_name\) \{\}/
    end
  end
end
