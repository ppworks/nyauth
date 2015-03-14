module Nyauth
  module SessionConcern
    extend ActiveSupport::Concern

    included do |base|
      if base.ancestors.include?(ActionController::Base)
        helper_method :signed_in?, :current_authenticated
        class_attribute :allow_actions
      end
    end

    # ex.)
    # sign_in(client)
    def sign_in(client)
      return unless client
      store_signed_in_session(client)
    end

    # ex.)
    # signed_in?(as: :user)
    def signed_in?(options = {})
      options.reverse_merge!(as: :user)
      session[signed_in_session_key].present?
    end

    # ex.)
    # sign_out
    def sign_out
      reset_session
    end

    # ex.)
    # before_action -> { require_authentication! as: :user }, only: :secret_action
    def require_authentication!(options = {})
      options.reverse_merge!(as: :user)
      return if self.class.allow_actions == :all
      return if self.class.allow_actions.present? && request[:action].to_sym.in?(self.class.allow_actions)
      head :unauthorized unless signed_in?(options)
    end

    def current_authenticated
      return nil unless session_value = session[signed_in_session_key]
      klass_name, client_id = Nyauth::Encryptor.decrypt(session_value).split(':')
      klass_name.constantize.find(client_id)
    end

    def store_signed_in_session(client)
      session[signed_in_session_key] = signed_in_session_object(client)
    end

    private

    def signed_in_session_key
      "sign_in_session"
    end

    def signed_in_session_object(client)
      Nyauth::Encryptor.encrypt("#{client.class.name}:#{client.id}")
    end

    module ClassMethods
      def allow_everyone(options = {})
        if options[:only]
          self.allow_actions = options[:only] || []
        else
          self.allow_actions = :all
        end
      end
    end
  end
end
