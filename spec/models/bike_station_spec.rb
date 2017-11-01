require 'rails_helper'

RSpec.describe BikeStation, type: :model do
  describe 'invalid params' do
    it 'requires a platform' do
      attrs = FactoryGirl.attributes_for(:bike_station, platform_id: nil)
      bs = BikeStation.new(attrs)
      expect(bs).not_to be_valid
    end
  end

  describe 'valid params' do
    it 'works well' do
      platform = FactoryGirl.create(:platform)
      attrs = FactoryGirl.attributes_for(:bike_station, platform_id: platform.id)
      bs = BikeStation.new(attrs)
      expect(bs).to be_valid
    end
  end


  describe 'registration in the platform' do
    before do
      @bs = FactoryGirl.create(:bike_station)
    end
    it 'ensure capabilities exist' do
      url = 'localhost:8000/catalog/capabilities'
      body = {
        id: 9999,
        name: 'free_bikeszzz',
        description: 'number of bikes available to hire',
        capability_type: 'sensor'
      }.to_json
      stub = stub_request(:post, url).to_return(status: 200, body: body)

      data = {
        data: {
          uuid: '92932bs'
        }
      }.to_json

      stub_request(:post, "http://localhost:8000/adaptor/components").to_return(status: 200, body: data, headers:{})
      @bs.fetch_or_register
      expect(stub).to have_been_requested.times(3)
    end

    it 'correctly register resources' do
      req_data = {'data' => {
        'lat' => '-23.0',
        'lon' => '-25.0',
        'description' => 'bike_station_uuid bike station',
        'capabilities' => [
          {'title' => 'slots',
          'typ' => 'sensor',
          'description' => 'the number of slots'
        },
          {'title' => 'free-bikes',
          'typ' => 'sensor',
          'description' => 'the number of bikes available to hire'
        },
          { 'title' => 'address',
            'typ' => 'sensor',
            'description' => 'the bike station address'
        },
          { 'title' => 'bike-station-uuid',
            'typ' => 'sensor',
            'description' => 'bike station identification extracted from extracted from external data source'
        },
          { 'title' => 'status',
          'typ' => 'sensor',
          'description' => 'information about the bike station'}
        ], 'status' => 'active'}
      }

      stub_request(:post, 'http://localhost:8000/adaptor/components').with(body: req_data).to_return(status: 200, body:'', headers: {})

      url = 'localhost:8000/catalog/capabilities'
      body = {
        id: 9999,
        name: 'free_bikeszzz',
        description: 'number of bikes available to hire',
        capability_type: 'sensor'
      }.to_json
      stub = stub_request(:post, url).to_return(status: 200, body: body)

      url = 'localhost:8000/adaptor/components'
      body = {
        data: { uuid: 'my-resource-9999' }
      }.to_json
      stub = stub_request(:post, url).to_return(status: 200, body: body)

      @bs.fetch_or_register
      expect(@bs.uuid).not_to eq(nil)

      url = 'http://localhost:8000/adaptor/components/my-resource-9999/data'
      body = {}.to_json
      stub = stub_request(:post, url).to_return(status: 200, body: body)
      new_data = {
        slots: [{value: 15, timestamp: Time.now}]
      }
      @bs.send_data(new_data)
    end
  end
end
