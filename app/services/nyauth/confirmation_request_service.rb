module Nyauth
  class ConfimationRequestService
    include ActiveModel::Model
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def save
      client.request_confirmation
      client.save
    end
  end
end
