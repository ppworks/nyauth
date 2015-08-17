module Nyauth
  class RegistrationService
    include ActiveModel::Model
    attr_reader :email, :password, :password_confirmation, :client

    def initialize(service_params = {})
      @email = service_params[:email]
      @password = service_params[:password]
      @password_confirmation = service_params[:password_confirmation]
    end

    def save(options = {})
      options.reverse_merge!(as: :user)
      klass = options[:as].to_s.classify.constantize
      @client = klass.create(email: @email,
                             password: @password,
                             password_confirmation: @password_confirmation)
      @errors = @client.errors
      @client.valid?
    end
  end
end
