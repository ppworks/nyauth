module Nyauth
  class RequestMailer < ActionMailer::Base
    default from: Nyauth.configuration.mailer_sender
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
