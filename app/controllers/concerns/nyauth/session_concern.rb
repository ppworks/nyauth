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
      current_authenticated.present? && current_authenticated.class.name.demodulize.underscore == options[:as].to_s
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

    def current_authenticated(options = {})
      options.reverse_merge!(as: :user)
      request.env['nyauth'].session.fetch(options[:as])
    end

    def store_signed_in_session(client)
      request.env['nyauth'].session.store(client, client.class.name.demodulize.underscore)
    end

    private

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
