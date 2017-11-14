require 'rails_helper'
require 'sidekiq/testing'
require 'helpers/interscity_mocks'
require 'helpers/geocoder_mocks'

RSpec.describe CitybikGathererWorker, type: :worker do
  describe '#perform' do
    before do
      @platform = FactoryGirl.create(:platform)
    end

    context 'invalid worker' do
      subject { CitybikGathererWorker.new.perform(0) }
      it 'raises error if invalid platform' do
        expect{subject}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'valid worker' do
      subject { CitybikGathererWorker.new.perform(@platform.id) }
      it 'call desired methods without errors' do
        soft_stub_citybik_request
        soft_stub_capabilities
        soft_stub_resource_registration('asdf1234')
        soft_stub_resource_data_sending('asdf1234')
        expect(BikeStation.count).to eq(0)
        subject
        expect(BikeStation.count).to eq(1)
        subject
        expect(BikeStation.count).to eq(1)
        expect{ subject }.not_to raise_error
      end
    end
  end
end
