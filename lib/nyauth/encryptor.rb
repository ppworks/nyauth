module Nyauth
  class Encryptor
    include Singleton

    cattr_writer :secret, :cipher, :digest
    self.secret = ENV['ENCRYPTION_SECRET'] || '46d9a00e79b6bbf1c64a829c5640f5798c2e7c5066493f6d7e56ba800fd17d62b9e2bdf9102ae915f22eb40f5d6c83d6b3266baa509de7fc330c88bd4947bf56'
    self.cipher = 'aes-256-cbc'
    self.digest = 'SHA512'

    attr_reader :encryptor

    def initialize
      @encryptor = ::ActiveSupport::MessageEncryptor.new(@@secret, cipher: @@cipher, digest: @@digest)
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
