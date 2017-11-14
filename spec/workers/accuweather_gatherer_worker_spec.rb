require 'rails_helper'
require 'sidekiq/testing'
require 'helpers/interscity_mocks'
require 'helpers/geocoder_mocks'

RSpec.describe AccuweatherGathererWorker, type: :worker do
  describe '#perform' do
    before do
      @platform = FactoryGirl.create(:platform)
    end

    it 'raises error if invalid platform' do
      expect{
        AccuweatherGathererWorker.new.perform(0)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'call desired methods' do
      accuweather_index_stub
      stub_accuweather_posts

      accuweather_addresses = File.open("./neighborhood").read
      accuweather_addresses.each_line do |n|
        stub_sao_paulo_coordinates(address="#{n.strip},%20S%C3%A3o%20Paulo")
      end
      soft_stub_capabilities
      soft_stub_resource_registration('asdf1234')
      soft_stub_resource_data_sending('asdf1234')

      worker = AccuweatherGathererWorker.new
      worker.perform(@platform.id)
      expect{worker.perform(@platform.id)}.not_to raise_error
    end
  end
end
