module Nyauth
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    source_root File.expand_path("../../../../app/views", __FILE__)
    desc "Creates Nyauth views for your application"

    def copy_views
      directory "nyauth", "app/views/nyauth"
      puts "copy views complete"
    end
  end
end
