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

    config.nyauth = ActiveSupport::OrderedOptions.new
    config.i18n.load_path += Dir[Engine.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.generators do |g|
      g.test_framework      :rspec,        fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
