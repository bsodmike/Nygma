require 'rails_helper'

RSpec.describe Nygma::Encryptor do
  let(:key) {
    'f46c1fb228aac44e55f82293a2341fb47c6f12c3721382ae7dbfe2e912941f59191efbc711f1ea5e'
  }
  let(:salt) {
    '[d\x89\r\xF6\xEB7\x9C\n\x1F+\xCAG\xF1g\e\x9Bg\xA7-:iG\b4\x03\xED\xCE\x8F>OH\b\x80\x8F\xE3\x17j\x1D\xA6\b?3\xC4\xE4\x8D\x9Eb\xA5\xB0\xB6jS\xAD\v\xE4\xBB\xDB\xF7\xFC\xBC\x04\xFD\xE4'
  }
  let(:payload) { "foo" }

  subject { described_class.crypt!(key, salt) }

  describe '#crypt!' do
    it { is_expected.to be_an_instance_of(described_class) }
  end

  context 'with a fixed key/salt pair' do
    context 'when given a payload' do

      context '#encrypt' do
        it 'should return the encrypted data' do
          expect(subject.encrypt(payload)).to_not eq(payload)
        end
      end

      context '#decrypt' do
        it 'should return the decrypted data' do
          secret = subject.encrypt(payload)
          expect(subject.decrypt(secret)).to eq(payload)
        end
      end

      context 'when given a static payload for decryption' do
        it 'should return the decrypted data' do
          static_payload ='bEpvZ1diMG5jMjFuVENlbENyRkNvZz09LS1iV1VVaFJSRkNYbnZscHpnUUQxUlhRPT0=--4e8ba51b6f97f52d67e234c55f4302b9f6e1b290'
          expect(subject.decrypt(static_payload)).to eq(payload)

          static_payload = 'Z3pHdlJXRTVUSUJXR3U4a0poM3VkZz09LS1FKzJ5RG94MGozZ1FxaExtNkd1WDBBPT0=--4fb32a5e068bec4d35fe4ba3dd36377704f3371e'
          expect(subject.decrypt(static_payload)).to eq(payload)
        end
      end

    end
  end

  context 'with modified key/salt strings' do
    let(:key) { 'aaabbbccc' }
    subject do
      described_class.crypt!(key, salt)
    end

    context 'when given a static payload (encrypted with different key/salt strings) for decryption' do
      it 'should raise exception' do
        static_payload ='bEpvZ1diMG5jMjFuVENlbENyRkNvZz09LS1iV1VVaFJSRkNYbnZscHpnUUQxUlhRPT0=--4e8ba51b6f97f52d67e234c55f4302b9f6e1b290'
        expect { subject.decrypt(static_payload) }.to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)

        static_payload = 'Z3pHdlJXRTVUSUJXR3U4a0poM3VkZz09LS1FKzJ5RG94MGozZ1FxaExtNkd1WDBBPT0=--4fb32a5e068bec4d35fe4ba3dd36377704f3371e'
        expect { subject.decrypt(static_payload) }.to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)
      end
    end

  end

end
