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
        record = candidate_for_authentication(given_email)
        return nil unless record

        record.verify_password?(given_password) ? record : nil
      end

      def candidate_for_authentication(given_email)
        with_given_email(given_email).last
      end
    end
  end
end
