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

  describe '#associations' do
    it { is_expected.to have_many(:items).dependent(:destroy) }
  end

  describe '#callbacks' do
    describe '#fill_inventory' do
      before { subject.save }

      it { expect(subject.items.count).to eq(4) }

      it { expect(subject.items.water.count).to eq(1) }
      it { expect(subject.items.food.count).to eq(1) }
      it { expect(subject.items.medication.count).to eq(1) }
      it { expect(subject.items.ammunition.count).to eq(1) }
    end
  end
end
