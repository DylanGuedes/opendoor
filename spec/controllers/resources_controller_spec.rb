require 'rails_helper'

RSpec.describe ResourcesController, type: :controller do
  describe "#index" do
    before do
      FactoryGirl.create(:weather)
      FactoryGirl.create(:air_quality)
    end

    it 'return all resources' do
      get :index
      expect(response).to have_http_status(:success)
      resources = Weather.all + AirQuality.all
      expect(assigns[:resources]).to eq(resources)
    end
  end

  describe '#fetch_cetesb_data' do
    before do
      @platform = FactoryGirl.create(:platform)
    end

    subject { get :fetch_cetesb_data }

    it 'should work' do
      @request.cookies[:instance_id] = @platform.id
      subject
      expect(CetesbGathererWorker).to have_enqueued_sidekiq_job(@platform.id)
      expect(response).to have_http_status(:redirect)
    end

    it 'shouldnt work with invalid platform' do
      @request.cookies[:instance_id] = nil
      subject
      expect(CetesbGathererWorker).not_to have_enqueued_sidekiq_job(@platform.id)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe '#fetch_citybik_data' do
    before do
      @platform = FactoryGirl.create(:platform)
    end

    it 'should works' do
      @request.cookies[:instance_id] = @platform.id
      get :fetch_citybik_data
      expect(CitybikGathererWorker).to have_enqueued_sidekiq_job(@platform.id)
      expect(response).to have_http_status(:redirect)
    end

    it 'dont queue if using invalid platform' do
      @request.cookies[:instance_id] = nil
      get :fetch_citybik_data
      expect(CitybikGathererWorker).not_to have_enqueued_sidekiq_job
      expect(response).to have_http_status(:redirect)
    end
  end

  describe '#fetch_accuweather_data' do
    before do
      @platform = FactoryGirl.create(:platform)
    end

    it 'returns 302' do
      @request.cookies[:instance_id] = @platform.id
      get :fetch_accuweather_data
      expect(response).to have_http_status(:redirect)
    end
  end

  describe '#dump_recovery' do
    it 'returns 200' do
      get :dump_recovery
      expect(response).to have_http_status(:success)
    end
  end

  describe '#dump_and_inject' do
    before do
      @platform = FactoryGirl.create(:platform)
    end

    let(:attrs) {
      {
        db_host: '127.0.0.1',
        db_name: 'sp',
        platform_id: @platform.id,
        resource_type: 'Weather'
      }
    }

    it 'returns 302' do
      get :dump_and_inject, params: attrs
      expect(response).to have_http_status(:redirect)
    end
  end
end
