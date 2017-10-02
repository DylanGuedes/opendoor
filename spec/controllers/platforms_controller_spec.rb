require 'rails_helper'

RSpec.describe PlatformsController, type: :controller do
  describe "#index" do
    before do
      5.times do |a|
        FactoryGirl.create(:platform, url: a.to_s*6)
      end
    end
    it 'should return platform instances' do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns[:platforms]).to eq(Platform.all)
    end
  end

  describe "#create" do
    let(:valid_attributes){ FactoryGirl.attributes_for :platform }
    let(:invalid_attributes){ FactoryGirl.attributes_for :platform, url: "" }

    context "with valid attrs" do
      subject { post :create, params: { platform: valid_attributes } }

      it 'should correctly create a platform' do
        expect{ subject }.to change(Platform, :count).by(1)
      end
    end

    context "with invalid attrs" do
      subject { post :create, params: { platform: invalid_attributes } }

      it 'should correctly create a platform' do
        expect{ subject }.to change(Platform, :count).by(0)
      end
    end
  end

  describe "#show" do
    before do
      @platform = FactoryGirl.create(:platform)
    end

    subject { get :show, params: { id: @platform.id } }
    it 'should return the correct platform' do
      subject
      expect(assigns[:platform]).to eq(@platform)
    end
  end
end
