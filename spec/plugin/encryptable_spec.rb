require 'rails_helper'

class EncryptableTestModel < ActiveRecord::Base
  encrypt :token
end

RSpec.describe Nygma::Encryptable do

  let(:key) {
    'f46c1fb228aac44e55f82293a2341fb47c6f12c3721382ae7dbfe2e912941f59191efbc711f1ea5e'
  }
  let(:salt) {
    '[d\x89\r\xF6\xEB7\x9C\n\x1F+\xCAG\xF1g\e\x9Bg\xA7-:iG\b4\x03\xED\xCE\x8F>OH\b\x80\x8F\xE3\x17j\x1D\xA6\b?3\xC4\xE4\x8D\x9Eb\xA5\xB0\xB6jS\xAD\v\xE4\xBB\xDB\xF7\xFC\xBC\x04\xFD\xE4'
  }
  begin(:all)
    Rails.application.config.encryptor = Nygma::Encryptor.crypt!(
      '4f83782f20a16b81bf592869a665d3623e2954a8cdee5ef20a3463ccae329ab63a5e2cee9f1a044c',
      'qB\xF5\x1F`3\xE0\x1A\xC0\xA2\xF6\xC2\xAD#&\x01\x01.\xA7\x15?\xC1\xF6\x80\xC5\xC3\xEA\x8F\x92(v\x15\x1DS\x12=\xA0^u\xEB}\x8AA\xA2\xE6G\x15{\xAA\x87\xC2\x15B\xF4\xAFs\x1F\x8Bm\x10W\x95\xE1'
    )
  end
  let(:payload) { "Test message" }
  let(:subject) {
      o = EncryptableTestModel.new
      o.token = payload
      o
  }

  describe '::encrypt' do

    it 'should override accessors to store encrypted hash and return decrypted value' do
      expect(subject.token).to eq(payload)
      expect(subject[:token]).not_to eq(payload)
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
