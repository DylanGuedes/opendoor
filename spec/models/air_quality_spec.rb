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
      url = 'localhost:8000/catalog/capabilities'
      body = {
        id: 9999,
        name: "temperaturezzz",
        description: "Float value in celcius",
        capability_type: "sensor"
      }.to_json
      stub = stub_request(:post, url).to_return(status: 200, body: body)

      data = {
        data: {
          uuid: '92932hi'
        }
      }.to_json
      stub_request(:post, "http://localhost:8000/adaptor/components").to_return(status: 200, body: data, headers: {})
      @aq.fetch_or_register
      expect(stub).to have_been_requested.times(3)
    end

    it 'correctly register resources' do
      req_data = {"data"=>{
        "lat"=>"-23.0",
        "lon"=>"-25.0",
        "description"=>"sao-paulo air quality",
        "capabilities"=> [
          {"title"=>"air-quality",
           "typ"=>"sensor",
           "description"=>"air quality of a given region"
        },
        {"title"=>"polluting-index",
         "typ"=>"sensor",
         "description"=>"polluting index.."
        }, {"title"=>"polluting",
            "typ"=>"sensor",
            "description"=>"type of polluting"}
        ], "status"=>"active"}
      }

      stub_request(:post, "http://localhost:8000/adaptor/components").with(body: req_data).to_return(status: 200, body: "", headers: {})

      url = 'localhost:8000/catalog/capabilities'
      body = {
        id: 9999,
        name: "temperaturezzz",
        description: "Float value in celcius",
        capability_type: "sensor"
      }.to_json
      stub = stub_request(:post, url).to_return(status: 200, body: body)

      url = 'localhost:8000/adaptor/components'
      body = {
        data: {
          uuid: 'my-resource-9999'
        }
      }.to_json
      stub = stub_request(:post, url).to_return(status: 200, body: body)

      @aq.fetch_or_register
      expect(@aq.uuid).not_to eq(nil)

      url = 'http://localhost:8000/adaptor/components/my-resource-9999/data'
      body = {
      }.to_json
      stub = stub_request(:post, url).to_return(status: 200, body: body)

      new_data = {
        air_quality: [{value: 10, timestamp: Time.now}]
      }
      @aq.send_data(new_data)

    end
  end
end
