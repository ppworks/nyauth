module Nyauth
  module Authenticatable
    extend ActiveSupport::Concern
    include Nyauth::PasswordDigestAbility
    include Nyauth::ResetPasswordAbility

    included do
      validates :email, presence: true
      scope :with_given_email, -> (given_email) {
        where(email: given_email)
      }
    end

    module ClassMethods
      def authenticate(given_email, given_password)
        record = with_given_email(given_email).last
        return nil unless record

        record.verify_password?(given_password) ? record : nil
      end
    end
  end
end
