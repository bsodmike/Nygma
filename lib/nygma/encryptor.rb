module Nygma
  class Encryptor
    pattr_initialize :key, :salt

    class << self
      def crypt!(key, salt)
        new(key, salt).call
      end
    end

    def call
      _key = ActiveSupport::KeyGenerator.new(key).
        generate_key(salt)
      crypt = ActiveSupport::MessageEncryptor.new(_key)
    end

  end
end
