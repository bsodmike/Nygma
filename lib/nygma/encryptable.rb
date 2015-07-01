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

      def encrypt(*args)
        args.each do |attribute|
          unless has_column?(attribute)
            Rails.logger.tagged('Nygma::Encryptable::encrypt') {
              Rails.logger.info "Unable to encrypt missing attribute #{attribute} in #{self.name}, check your migrations!"
            }
          else
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

      private
      def has_column?(attribute)
        return true if self.column_names.include?(attribute.to_s)

        false
      end

    end
  end

end
