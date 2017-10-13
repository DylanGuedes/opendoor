require 'rails_helper'

RSpec.describe AirQuality, type: :model do
  describe "registration in the platform" do
    before do
      @aq = FactoryGirl.create(:air_quality)
    end

    it 'works for correct values' do
      @aq.fetch_or_register
      expect(@aq.uuid).not_to eq(nil)
      new_data = {
        air_quality: [{value: 10, timestamp: Time.now}]
      }
      @aq.send_data(new_data)
    end
  end
end
