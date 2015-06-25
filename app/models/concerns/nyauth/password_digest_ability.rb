module Nyauth
  module PasswordDigestAbility
    extend ActiveSupport::Concern

    included do
      attr_accessor :password, :password_confirmation
      validates :password_digest, presence: true
      before_validation do
        set_password_salt if password.present?
        set_password_digest if password.present?
      end
    end

    def verify_password?(raw_password)
      password_digest == generate_password_digest(raw_password)
    end

    private

    def generate_password_digest(password)
      Nyauth.configuration.password_digest_stretches.times do
        password = Digest::SHA256.hexdigest("#{password}#{password_salt}")
      end
      password
    end

    def generate_password_salt
      "#{id}#{SecureRandom.hex(128)}"
    end

    def set_password_salt
      self.password_salt = generate_password_salt
    end

    def set_password_digest
      self.password_digest = generate_password_digest(password)
    end
  end
end
