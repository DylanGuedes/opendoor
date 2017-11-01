require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe CetesbGathererWorker, type: :worker do
  describe 'normal job scheduling' do
    it 'should create resources' do
      file = File.open("spec/cetesb.html")
      data = file.read
      file.close

      stub_request(:get, "http://sistemasinter.cetesb.sp.gov.br/Ar/php/ar_resumo_hora.php").
        with{|request| not request.headers.blank?}.to_return(status: 200, body: data, headers: {'Content-Type': 'text/html'})

      capabilities_url = "http://localhost:8000/catalog/capabilities"
      data = {"capability_type"=>"sensor", "description"=>"air quality of a given region", "name"=>"air-quality"}

      body = {
        id: 9999,
        name: "temperaturezzz",
        description: "Float value in celcius",
        capability_type: "sensor"
      }.to_json

      stub_request(:post, capabilities_url).
        with{|request| not request.body.blank? and not request.headers.blank?}.to_return(status: 200, body: body, headers: {})

      data = {"capability_type"=>"sensor", "description"=>"polluting index..", "name"=>"polluting-index"}
      stub_request(:post, capabilities_url).
        with{|request| request.body==data and not request.headers.blank?}.to_return(status: 200, body: body, headers: {})

      data = {"capability_type"=>"sensor", "description"=>"type of polluting", "name"=>"polluting"}
      stub_request(:post, capabilities_url).
        with{|request| request.body == data and not request.headers.blank?}.to_return(status: 200, body: body, headers: {})

      body = {
        "data"=>{
          "lat"=>"-23.559616",
          "lon"=>"-1.55",
          "description"=>"Capão Redondo air quality",
          "capabilities"=>[
            {"title"=>"air-quality", "typ"=>"sensor", "description"=>"air quality of a given region"},
            {"title"=>"polluting-index", "typ"=>"sensor", "description"=>"polluting index.."},
            {"title"=>"polluting", "typ"=>"sensor", "description"=>"type of polluting"}
          ],
          "status"=>"active"}
      }

      req_body = {
        data: {
          uuid: '92932hi'
        }
      }.to_json
      stub_request(:post, "http://localhost:8000/adaptor/components").
        with{|request| not request.body.blank?}.to_return(status: 200, body: req_body, headers: {})

      stub_request(:post, "http://localhost:8000/adaptor/components/92932hi/data").
        with{|request| not request.body.blank?}.to_return(status: 200, body: req_body, headers: {})

      req_body = {
        results: [{
          address_components: [
            {
              long_name: "São Paulo",
              short_name: "São Paulo",
              types: [ "locality", "political" ]
            },
            {
              long_name: "São Paulo",
              short_name: "São Paulo",
              types: [ "administrative_area_level_2", "political" ]
            },
            {
               long_name: "State of São Paulo",
               short_name: "SP",
               types: [ "administrative_area_level_1", "political" ]
            },
            {
               long_name: "Brazil",
               short_name: "BR",
               types: [ "country", "political" ]
            }
          ],
          formatted_address: "São Paulo, State of São Paulo, Brazil",
          geometry: {
            bounds: {
              northeast: {
                lat: -23.3566039,
                lng: -46.3650844
              },
              southwest: {
                lat: -24.0082209,
                lng: -46.825514
              }
            },
            location: {
              lat: -23.5505199,
              lng: -46.63330939999999
            },
            location_type: "APPROXIMATE",
            viewport: {
              northeast: {
                lat: -23.3566039,
                lng: -46.3650844
              },
              southwest: {
                lat: -24.0082209,
                lng: -46.825514
              }
            }
          },
          place_id: "ChIJ0WGkg4FEzpQRrlsz_whLqZs",
          types: [ "locality", "political" ]
        }
        ],
        status: "OK"
      }.to_json

      stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=Cidade&language=en&sensor=false").
        with{|request| not request.headers.blank?}.to_return(status: 200, body: req_body, headers: {})

      id = FactoryGirl.create(:platform).id
      Sidekiq::Testing.inline! do
        old_count = AirQuality.count
        CetesbGathererWorker.new.perform(AirQuality.workers[:cetesb_gatherer_worker], id)
        expect(AirQuality.count).not_to eq(old_count)

        old_count = AirQuality.count
        CetesbGathererWorker.new.perform(AirQuality.workers[:cetesb_gatherer_worker], id)
        expect(AirQuality.count).to eq(old_count)
      end
    end
  end
end
