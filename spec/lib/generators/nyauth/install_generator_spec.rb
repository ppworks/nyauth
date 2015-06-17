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
      assert_file 'config/initializers/nyauth.rb', /config.redirect_path_after_sign_in/
      assert_file 'config/initializers/nyauth.rb', /config.redirect_path_after_sign_out/
      assert_file 'config/initializers/nyauth.rb', /config.redirect_path do |urls|/
    end
  end
end
