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

  describe '#methods' do
    describe '#flag_infected #infected?' do
      context 'once' do
        let(:infected) { create(:survivor, infection_flags_count: 0) }

        before { infected.flag_infected }

        it { expect(infected.infection_flags_count).to eq(1) }
        it { expect(infected.infected?).to be_falsey }
      end

      context 'twice' do
        let(:infected) { create(:survivor, infection_flags_count: 1) }

        before { infected.flag_infected }

        it { expect(infected.infection_flags_count).to eq(2) }
        it { expect(infected.infected?).to be_falsey }
      end

      context 'three times' do
        let(:infected) { create(:survivor, infection_flags_count: 2) }

        before { infected.flag_infected }

        it { expect(infected.infection_flags_count).to eq(3) }
        it { expect(infected.infected?).to be_truthy }
      end
    end
  end
end
