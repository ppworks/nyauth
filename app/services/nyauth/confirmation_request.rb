module Nyauth
  class ConfirmationRequest
    include ActiveModel::Model
    attr_reader :email, :client

    def initialize(service_params = {})
      @email = service_params[:email]
    end

    def save(options = {})
      options.reverse_merge!(as: :user)
      klass = options[:as].to_s.classify.constantize
      @client = klass.with_given_email(@email).last!
      @client.request_confirmation
    rescue
      errors.add(:base, :invalid_email)
    end
  end
end
