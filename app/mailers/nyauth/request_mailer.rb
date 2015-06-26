module Nyauth
  class RequestMailer < ActionMailer::Base
    default from: "from@example.com"
    layout 'nyauth/mailer'
    def request_confirmation(client)
      @client = client
      mail to: client.email
    end

    def request_reset_password(client)
      @client = client
      mail to: client.email
    end
  end
end
