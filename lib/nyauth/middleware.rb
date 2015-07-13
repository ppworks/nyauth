require 'nyauth/nyan'

module Nyauth
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      return @app.call(env) if env['nyauth']
      env['nyauth'] = Nyauth::Nyan.new(env)
      Nyauth::Nyan.run_callback env['nyauth'] do
        @app.call(env)
      end
    end
  end
end
