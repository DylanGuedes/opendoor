require 'rails_helper'
require 'sidekiq/testing'
require 'helpers/interscity_mocks'
require 'helpers/geocoder_mocks'

RSpec.describe CetesbGathererWorker, type: :worker do
  describe 'normal job scheduling' do
    it 'should create resources' do
      soft_stub_capabilities

      file = File.open("spec/cetesb.html")
      data = file.read
      file.close

      cetesb_url = "http://sistemasinter.cetesb.sp.gov.br/Ar/php/ar_resumo_hora.php"
      stub_request(:get, cetesb_url).
        with{|request| not request.headers.blank?}.
        to_return(status: 200, body: data, headers: {'Content-Type': 'text/html'})

      CAPABILITIES = [
        {"capability_type"=>"sensor", "name"=>"polluting-index"},
        {"capability_type"=>"sensor", "name"=>"polluting"},
      ]

      CAPABILITIES.each do |c|
        soft_stub_specific_capability(c)
      end

      soft_stub_resource_registration('asdf1234')
      soft_stub_resource_data_sending('asdf1234')
      stub_sao_paulo_coordinates("Cidade")

      id = FactoryGirl.create(:platform).id
      Sidekiq::Testing.inline! do
        old_count = AirQuality.count
        CetesbGathererWorker.new.perform(id)
        expect(AirQuality.count).not_to eq(old_count)

        old_count = AirQuality.count
        CetesbGathererWorker.new.perform(id)
        expect(AirQuality.count).to eq(old_count)
      end
    end
  end
end
