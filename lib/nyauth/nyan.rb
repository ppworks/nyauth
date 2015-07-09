require 'nyauth/session_serializer'

module Nyauth
  class Nyan
    def initialize(env)
      @env = env
    end

    def session
      @session_serializer ||= Nyauth::SessionSerializer.new(@env)
    end
  end
end
