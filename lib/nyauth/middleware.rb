require 'nyauth/nyan'

module Nyauth
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      return @app.call(env) if env['nyauth']

      env['nyauth'] = Nyauth::Nyan.new(env)
      @app.call(env)
    end
  end
end
