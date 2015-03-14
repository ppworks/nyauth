module Nyauth
  class SessionService
    include ActiveModel::Model
    attr_reader :email, :password, :client

    def initialize(session_service_params = {})
      @email = session_service_params[:email]
      @password = session_service_params[:password]
    end

    def save(options = {})
      options.reverse_merge!(as: :user)
      klass = options[:as].to_s.classify.constantize
      @client = klass.authenticate(email, password)
      errors.add(:client, 'invalid email or password') unless @client
      client
    rescue
      errors.add(:client, 'invalid email or password')
    end
  end
end
