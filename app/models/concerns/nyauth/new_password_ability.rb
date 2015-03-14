module Nyauth
  module NewPasswordAbility
    extend ActiveSupport::Concern

    included do
      before_validation :check_new_password_key, on: :new_password
    end

    def update_new_password(params)
      self.attributes = params
      self.save(context: :new_password)
    end

    def request_new_password
      self.new_password_key = SecureRandom.hex(32)
      self.new_password_key_expired_at = Time.current + 1.hour
      save
    end

    private

    def check_new_password_key
      if new_password_key_expired_at.past?
        errors.add(:new_password_key, :expired)
      else
        self.new_password_key = nil
      end
    end
  end
end
