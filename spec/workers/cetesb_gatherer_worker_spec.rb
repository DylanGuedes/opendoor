require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe CetesbGathererWorker, type: :worker do
  describe 'normal job scheduling' do
    it 'should create resources' do
      headers = {
        'Accept'=>'*/*', 'Accept-Charset'=>'ISO-8859-1,utf-8;q=0.7,*;q=0.7',
        'Accept-Encoding'=>'gzip,deflate,identity',
        'Accept-Language'=>'en-us,en;q=0.5',
        'Connection'=>'keep-alive',
        'Host'=>'sistemasinter.cetesb.sp.gov.br',
        'Keep-Alive'=>'300',
        'User-Agent'=>'Mechanize/2.7.5 Ruby/2.3.3p222 (http://github.com/sparklemotion/mechanize/)',
        'Content-Type'=>'application/x-www-form-urlencoded'
      }

      file = File.open("spec/cetesb.html")
      data = file.read
      file.close

      stub_request(:get, "http://sistemasinter.cetesb.sp.gov.br/Ar/php/ar_resumo_hora.php").
        with{|request| not request.headers.blank?}.to_return(status: 200, body: data, headers: {'Content-Type': 'text/html'})

      headers = {
        'Accept'=>'*/*', 'Accept-Charset'=>'ISO-8859-1,utf-8;q=0.7,*;q=0.7',
        'Accept-Encoding'=>'gzip,deflate,identity',
        'Accept-Language'=>'en-us,en;q=0.5',
        'Connection'=>'keep-alive',
        'Host'=>'sistemasinter.cetesb.sp.gov.br',
        'Keep-Alive'=>'300',
        'User-Agent'=>'Mechanize/2.7.5 Ruby/2.3.3p222 (http://github.com/sparklemotion/mechanize/)'
      }
      stub_request(:get, "http://sistemasinter.cetesb.sp.gov.br/Ar/php/ar_resumo_hora.php").
        with(headers: headers).to_return(status: 200, body: data, headers: {'Content-Type': 'text/html'})

      capabilities_url = "http://localhost:8000/catalog/capabilities"
      data = {"capability_type"=>"sensor", "description"=>"air quality of a given region", "name"=>"air-quality"}
      headers = {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip, deflate',
        'Content-Length'=>'81',
        'Content-Type'=>'application/x-www-form-urlencoded',
        'Host'=>'localhost:8000',
        'User-Agent'=>'rest-client/2.0.2 (linux-gnu x86_64) ruby/2.3.3p222'
      }

      body = {
        id: 9999,
        name: "temperaturezzz",
        description: "Float value in celcius",
        capability_type: "sensor"
      }.to_json

      stub_request(:post, capabilities_url).
        with(body: data, headers: headers).to_return(status: 200, body: body, headers: {})

      headers = {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip, deflate',
        'Content-Length'=>'73',
        'Content-Type'=>'application/x-www-form-urlencoded',
        'Host'=>'localhost:8000',
        'User-Agent'=>'rest-client/2.0.2 (linux-gnu x86_64) ruby/2.3.3p222'
      }
      data = {"capability_type"=>"sensor", "description"=>"polluting index..", "name"=>"polluting-index"}
      stub_request(:post, capabilities_url).
        with(body: data, headers: headers).to_return(status: 200, body: body, headers: {})

      headers = {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip, deflate',
        'Content-Length'=>'67',
        'Content-Type'=>'application/x-www-form-urlencoded',
        'Host'=>'localhost:8000',
        'User-Agent'=>'rest-client/2.0.2 (linux-gnu x86_64) ruby/2.3.3p222'
      }
      data = {"capability_type"=>"sensor", "description"=>"type of polluting", "name"=>"polluting"}
      stub_request(:post, capabilities_url).
        with(body: data, headers: headers).to_return(status: 200, body: body, headers: {})

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

      headers = {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip, deflate',
        'Content-Length'=>'494',
        'Content-Type'=>'application/x-www-form-urlencoded',
        'Host'=>'localhost:8000',
        'User-Agent'=>'rest-client/2.0.2 (linux-gnu x86_64) ruby/2.3.3p222'
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
