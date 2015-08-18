module Nyauth
  class Session
    include ActiveModel::Model
    attr_reader :email, :password, :client

    def initialize(service_params = {})
      @email = service_params[:email]
      @password = service_params[:password]
    end

    def save(options = {})
      options.reverse_merge!(as: :user)
      klass = options[:as].to_s.classify.constantize
      @client = klass.authenticate(email, password)
      errors.add(:base, :invalid_email_or_password) unless @client
      client
    rescue
      errors.add(:base, :invalid_email_or_password)
    end
  end
end
