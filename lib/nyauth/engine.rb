Gem.loaded_specs['nyauth'].dependencies.each do |d|
  begin
    require d.name.gsub('-', '/')
  rescue LoadError
    require d.name
  end
end

module Nyauth
  class Engine < ::Rails::Engine
    isolate_namespace Nyauth

    config.generators do |g|
      g.test_framework      :rspec,        fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer 'nyauth.add_middleware' do |app|
      app.middleware.use Nyauth::Middleware
    end
  end
end
