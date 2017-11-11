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
      ssrd = soft_stub_resource_data('asdf1234')
      ssc = soft_stub_capabilities
      @bs.fetch_or_register
      expect(ssrd).to have_been_requested.times(1)
      expect(ssc).to have_been_requested.times(2)
    end

    it 'correctly register resources' do
      ssrd = soft_stub_resource_data('asdf1234')
      ssrr = soft_stub_resource_registration('asdf1234')
      ssrds = soft_stub_resource_data_sending('asdf1234')
      ssc = soft_stub_capabilities

      @bs.fetch_or_register
      expect(@bs.uuid).not_to eq(nil)

      new_data = {
        slots: [{value: 15, timestamp: Time.now}]
      }
      expect(ssrds).to have_been_requested.times(0)
      @bs.send_data(new_data)
      expect(ssrds).to have_been_requested.times(1)
    end
  end
end
