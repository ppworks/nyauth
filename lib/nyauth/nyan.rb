require 'nyauth/session_serializer'

module Nyauth
  class Nyan
    def initialize(env)
      @env = env
    end

    def session
      @serializer ||= Nyauth::SessionSerializer.new(@env)
    end

    def self.run_callback(nyan, &block)
      %w(on_test_request).each do |kind|
        __send__("_#{kind}").each do |callback, options|
          callback.call(nyan, *options)
        end
      end

      @@_on_test_request = []
      yield
    end

    def self.on_test_request(options = {}, &block)
      _on_test_request.push([block, options])
    end

    def self._on_test_request
      @@_on_test_request ||= []
    end
  end
end
