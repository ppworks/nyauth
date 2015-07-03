module Nyauth
  class Encryptor
    include Singleton

    cattr_writer :secret, :cipher, :digest
    self.cipher = 'aes-256-cbc'
    self.digest = 'SHA512'

    attr_reader :encryptor

    def initialize
      @encryptor = ::ActiveSupport::MessageEncryptor.new(Nyauth.configuration.encryption_secret, cipher: @@cipher, digest: @@digest)
    end

    class << self
      def encrypt(message)
        instance.encryptor.encrypt_and_sign(message)
      end

      def decrypt(encrypted_message)
        instance.encryptor.decrypt_and_verify(encrypted_message)
      end
    end
  end
end
