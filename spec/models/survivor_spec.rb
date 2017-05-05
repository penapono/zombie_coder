# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Survivor, type: :model do
  subject(:survivor) { build(:survivor) }

  describe '#factory' do
    context '#valid' do
      it { is_expected.to be_valid }
    end

    context '#invalid' do
      it { expect(build(:survivor, :invalid)).not_to be_valid }
    end
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :age }
    it { is_expected.to validate_presence_of :gender }
    it { is_expected.to validate_presence_of :latitude }
    it { is_expected.to validate_presence_of :longitude }
  end
end
