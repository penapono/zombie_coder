require 'rails_helper'

RSpec.describe Api::V1::ReportsController, type: :controller do
  let!(:non_infected) { create(:survivor) }
  let!(:infected) { create(:survivor, infection_flags_count: 3) }

  describe '#infected' do
    let(:expected) { "50.0%" }
    before do
      get :infected
      @json_response = JSON.parse(response.body)
    end

    it { expect(@json_response["rate"]).to eq(expected) }
  end

  describe '#non_infected' do
    let(:expected) { "50.0%" }
    before do
      get :non_infected
      @json_response = JSON.parse(response.body)
    end

    it { expect(@json_response["rate"]).to eq(expected) }
  end

  describe '#average_resource' do
    let(:expected) do
      {
        "water" => "1.0", "food" => "1.0",
        "medication" => "1.0", "ammunition" => "1.0"
      }
    end

    before do
      get :average_resource
      @json_response = JSON.parse(response.body)
    end

    it { expect(@json_response["rate"]).to eq(expected) }
  end

  describe '#lost_points' do
    let(:expected) { 10 }
    before do
      get :lost_points
      @json_response = JSON.parse(response.body)
    end

    it { expect(@json_response["rate"]).to eq(expected) }
  end
end
