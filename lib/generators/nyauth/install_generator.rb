module Nyauth
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    desc "Creates Nyauth initializer for your application"

    def copy_initializer
      template "nyauth_install_initializer.rb", "config/initializers/nyauth.rb"
      puts "Install complete"
    end
  end
end
