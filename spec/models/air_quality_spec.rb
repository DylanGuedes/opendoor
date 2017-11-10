require 'rails_helper'
require 'webmock/rspec'

RSpec.describe AirQuality, type: :model do
  describe "invalid params" do
    it "requires a platform" do
      attrs = FactoryGirl.attributes_for(:air_quality, platform_id: nil)
      aq = AirQuality.new(attrs)
      expect(aq).not_to be_valid
    end
  end

  describe "valid params" do
    it "works well" do
      platform = FactoryGirl.create(:platform)
      attrs = FactoryGirl.attributes_for(:air_quality, platform_id: platform.id)
      aq = AirQuality.new(attrs)
      expect(aq).to be_valid
    end
  end

  describe "registration in the platform" do
    before do
      @aq = FactoryGirl.create(:air_quality)
    end

    it 'ensure capabilities exist' do
      ssrd = soft_stub_resource_data('asdf1234')
      ssc = soft_stub_capabilities
      @aq.fetch_or_register
      expect(ssrd).to have_been_requested.times(1)
      expect(ssc).to have_been_requested.times(1)
    end

    it 'correctly register resources' do
      ssrd = soft_stub_resource_data('asdf1234')
      ssrr = soft_stub_resource_registration('asdf1234')
      ssrds = soft_stub_resource_data_sending('asdf1234')
      ssc = soft_stub_capabilities

      @aq.fetch_or_register
      expect(@aq.uuid).not_to eq(nil)

      new_data = {
        air_quality: [{value: 10, timestamp: Time.now}]
      }
      expect(ssrds).to have_been_requested.times(0)
      @aq.send_data(new_data)
      expect(ssrds).to have_been_requested.times(1)
    end
  end
end
