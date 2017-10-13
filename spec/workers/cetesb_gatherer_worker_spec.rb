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
