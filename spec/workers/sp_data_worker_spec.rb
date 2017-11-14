require 'rails_helper'
require 'sidekiq/testing'
require 'helpers/interscity_mocks'
require 'helpers/geocoder_mocks'

RSpec.describe SpDataWorker, type: :worker do
  describe '#perform' do
    before do
      @platform = FactoryGirl.create(:platform)
    end

    context 'valid worker' do
      subject {
        SpDataWorker.new.perform(@platform.id, 'mongodb://127.0.0.1', 'sp', 'AirQuality',1)
      }

      it 'does not raise errors' do
        soft_stub_capabilities
        soft_stub_resource_registration('asdf1234')
        soft_stub_resource_data_sending('asdf1234')
        stub_sao_paulo_coordinates(address="Cap%C3%A3o%20Redondo")
        subject
      end
    end
  end
end
