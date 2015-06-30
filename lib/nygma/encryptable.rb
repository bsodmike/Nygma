module Nygma

  module Encryptable

    class << self
      def included _klass
        _klass.class_eval do
          include InstanceMethods
          extend ClassMethods
        end
      end
    end

    module InstanceMethods

      protected
      def encryptor
        Rails.application.config.encryptor
      end

    end

    module ClassMethods

      def encrypt(attribute)
        attr = "#{attribute}"

        define_method("#{attr}") do
          encryptor.decrypt(self[attribute]) if self[attribute]
        end

        define_method("#{attr}=") do |val|
          encrypted_payload = encryptor.encrypt(val)
          self[attribute] = encrypted_payload if encrypted_payload
        end
      end

    end
  end

end
