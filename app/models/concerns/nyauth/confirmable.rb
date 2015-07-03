module Nyauth
  module Confirmable
    extend ActiveSupport::Concern

    included do
      before_validation :check_confirmation_key, on: :confirm
    end

    def confirm
      self.confirmed_at = Time.current
      save(context: :confirm)
    end

    def confirmed?
      self.confirmed_at.present?
    end

    def request_confirmation
      self.confirmation_key = SecureRandom.hex(32)
      self.confirmation_key_expired_at = Time.current + Nyauth.configuration.confirmation_expire_limit
      save
    end

    private

    def check_confirmation_key
      if confirmation_key_expired_at.past?
        errors.add(:confirmation_key, :expired)
      else
        self.confirmation_key = nil
      end
    end
  end
end
