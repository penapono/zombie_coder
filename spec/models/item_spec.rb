# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  subject(:item) { build(:item) }

  describe '#factory' do
    context '#valid' do
      it { is_expected.to be_valid }
    end

    context '#invalid' do
      it { expect(build(:item, :invalid)).not_to be_valid }
    end
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :ammount }
    it { is_expected.to validate_presence_of :points }
    it { is_expected.to validate_presence_of :survivor }
  end

  describe '#associations' do
    it { is_expected.to belong_to(:survivor) }
  end

  describe '#scopes' do
    let!(:water) { create(:item, name: 'water') }
    let!(:food) { create(:item, name: 'food') }
    let!(:medication) { create(:item, name: 'medication') }
    let!(:ammunition) { create(:item, name: 'ammunition') }

    it { expect(Item.water).to eq(Item.where(name: 'water')) }
    it { expect(Item.food).to eq(Item.where(name: 'food')) }
    it { expect(Item.medication).to eq(Item.where(name: 'medication')) }
    it { expect(Item.ammunition).to eq(Item.where(name: 'ammunition')) }
  end

  describe '#constants' do
    it { subject.class.should be_const_defined(:INITIAL) }
  end
end
