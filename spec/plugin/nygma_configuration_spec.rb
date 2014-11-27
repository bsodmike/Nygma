require 'rails_helper'
require 'Nygma'

RSpec.describe Nygma::Configuration do

  describe 'Nygma::Configuration' do
    it { is_expected.to be_kind_of(Module) }
  end

  describe '#secure_key' do
    it 'should have module accessors for secure_key' do
      expect(described_class.secure_key).to be_nil

      described_class.secure_key = "FOO"

      expect(described_class.secure_key).to eq("FOO")
    end
  end

  describe '#secure_salt' do
    it 'should have module accessors for secure_salt' do
      expect(described_class.secure_salt).to be_nil

      described_class.secure_salt = "BAR"

      expect(described_class.secure_salt).to eq("BAR")
    end
  end
end
