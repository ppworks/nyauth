module Nyauth
  class SessionSerializer
    def initialize(env)
      @env = env
    end

    def key_for(scope)
      "nyauth.#{scope}.session"
    end

    def serialize(client)
      Nyauth::Encryptor.encrypt("#{client.class.name}:#{client.id}")
    end

    def deserialize(key)
      klass_name, client_id = Nyauth::Encryptor.decrypt(key).split(':')
      klass_name.constantize.find(client_id)
    end

    def store(client, scope)
      return unless client
      session[key_for(scope)] = serialize(client)
    end

    def fetch(scope)
      key = session[key_for(scope)]
      return nil unless key

      client = deserialize(key)
      delete(scope) unless client
      client
    end

    def stored?(scope)
      !!session[key_for(scope)]
    end

    def delete(scope, client=nil)
      session.delete(key_for(scope))
    end

    def session
      @env['rack.session'] || {}
    end
  end
end
