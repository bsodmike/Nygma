module Nygma
  class Encryptor
    pattr_initialize :key, :salt
    attr_accessor :crypt

    class << self
      def crypt!(key, salt)
        new(key, salt).call
      end
    end

    def call
      _key = ActiveSupport::KeyGenerator.new(key).
        generate_key(salt)
      self.crypt = ActiveSupport::MessageEncryptor.new(_key)
      self
    end

    def encrypt(payload)
      crypt.encrypt_and_sign(payload)
    end

    def decrypt(payload)
      crypt.decrypt_and_verify(payload)
    end

  end
end
