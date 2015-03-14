module Nyauth
  class UserMailer < ActionMailer::Base
    default from: "from@example.com"
    layout 'nyauth/mailer'
    def request_confirmation(user)
      @user = user
      mail to: user.email
    end

    def request_new_password(user)
      @user = user
      mail to: user.email
    end
  end
end
