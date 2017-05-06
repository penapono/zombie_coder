require 'rails_helper'

RSpec.describe Api::V1::SurvivorsController, type: :controller do
  let!(:survivor) { create :survivor }
  let!(:survivors) { create_list :survivor, 3 }

  let(:permitted_params) do
    %i[
      name age gender latitude longitude
    ]
  end

  describe '#index' do
    let(:expected) { Survivor.all }
    let(:expected_count) { expected.count }

    before do
      get :index
      @json_response = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "all survivors" do
      expect(@json_response.size).to eq(expected_count)
    end
  end

  describe '#create' do
    let(:name) { "Name" }

    let(:valid_attributes) do
      build(:survivor, name: name).attributes
    end

    let(:invalid_attributes) do
      build(:survivor, :invalid, name: name).attributes
    end

    let(:valid_params)   { { survivor: valid_attributes } }
    let(:invalid_params) { { survivor: invalid_attributes } }

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:create, params: params).on(:survivor)
      end
    end

    context 'valid params' do
      before do
        post :create, params: valid_params
      end

      skip do
        it { expect(response.status).to eq(200) }
      end

      it 'have a valid id' do
        expect(JSON.parse(response.body)["id"]).to be_a(Numeric)
      end
    end

    context 'invalid params' do
      before do
        post :create, params: invalid_params
      end

      it 'returns error status' do
        expect(response.status).to eq(500)
      end
    end
  end

  describe '#show' do
    before { get :show, params: { id: survivor } }

    it { is_expected.to respond_with :success }

    it 'return survivor' do
      expect(JSON.parse(response.body).keys)
        .to eq(
          %w[id name age gender latitude longitude
             infection_flags_count infected? items]
        )
    end
  end

  describe '#update' do
    let(:name) { "Name" }
    let(:survivor) { create(:survivor, name: name) }

    let(:valid_attributes) do
      survivor.attributes
    end

    let(:invalid_attributes) do
      survivor = create(:survivor, name: name)
      survivor.name = nil
      survivor.attributes
    end

    let(:valid_params) do
      { id: valid_attributes['id'], survivor: valid_attributes }
    end

    let(:invalid_params) do
      { id: invalid_attributes['id'], survivor: invalid_attributes }
    end

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:update, params: params).on(:survivor)
      end
    end

    context 'valid params' do
      before { patch :update, params: valid_params }

      it { is_expected.to respond_with :success }
    end

    context 'invalid params' do
      before { patch :update, params: invalid_params }

      it { is_expected.to respond_with :error }
    end
  end

  describe '#flag_infected' do
    before { post :flag_infected, params: { id: survivor } }

    it { is_expected.to respond_with :success }

    it 'return message' do
      expect(JSON.parse(response.body)["message"])
        .to eq("Successfully marked as infected")
    end
  end

  describe '#trade' do
    context 'balanced and no infecteds' do
      let(:to_survivor) { create(:survivor) }
      let(:trade_from) do
        {
          items: survivor.items.pluck(:name)
        }
      end

      let(:trade_to) do
        {
          items: to_survivor.items.pluck(:name),
          id: to_survivor.id
        }
      end

      before do
        post :trade,
             params: {
               id: survivor.id,
               trade_from: trade_from,
               trade_to: trade_to
             }
      end

      it { is_expected.to respond_with :success }
    end
  end
end
