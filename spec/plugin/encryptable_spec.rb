require 'rails_helper'

class EncryptableTestModel < ActiveRecord::Base
  encrypt :token, :reference
end

RSpec.describe Nygma::Encryptable do

  let(:key) { SecureRandom.hex(40) }
  let(:salt) { SecureRandom.random_bytes(64) }
  begin(:all)
    Rails.application.config.encryptor = Nygma::Encryptor.crypt!(
      SecureRandom.hex(40),
      SecureRandom.random_bytes(64)
    )
  end
  let(:payload) { "Test message" }
  let(:subject) {
      o = EncryptableTestModel.new
      o.token = payload
      o.reference = payload
      o
  }

  describe '::encrypt' do

    it 'should override accessors to store encrypted hash and return decrypted value' do
      expect(subject.token).to eq(payload)
      expect(subject.reference).to eq(payload)
      expect(subject[:token]).not_to eq(payload)
      expect(subject[:reference]).not_to eq(payload)
      expect(subject[:token]).not_to eq(subject[:reference])
    end

    context 'when encryption key/salt change' do
      it 'should raise exception' do
        expect(subject.token).to eq(payload)
        expect(subject[:token]).not_to eq(payload)

        Rails.application.config.encryptor = Nygma::Encryptor.crypt!(key, salt)

        expect { subject.token }.to raise_exception Nygma::Encryptor::UnknownDecryptionError,
          /ActiveSupport::MessageVerifier::InvalidSignature/
      end
    end

    context 'when encrypting an invalid model attribute' do
      it 'should log a warning' do
        expect(Rails.logger).to receive(:info).and_call_original

        EncryptableTestModel.class_eval do
          encrypt :foo
        end
      end
    end

  end

end
