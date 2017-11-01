require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe InitiativeRegistrationWorker, type: :worker do
  describe 'normal job scheduling' do
    it 'should create resources' do

    capabilities_url = "http://localhost:8000/catalog/capabilities"
    body = {
    }.to_json

    stub_request(:post, capabilities_url).
      with{|request| not request.body.blank? and not request.headers.blank?}.to_return(status: 200, body: body, headers: {})

    registration_url = "http://localhost:8000/adaptor/components"
    body = {
      data: {
        uuid: '92932hi'
      }
    }.to_json

    stub_request(:post, registration_url).
      with{|request| not request.body.blank? and not request.headers.blank?}.to_return(status: 200, body: body, headers: {})

    body = {
      name: "IME",
      institution: "IME",
      address: "Rua do Matao 1010",
      city: "São Paulo",
      state: "SP",
      responsible: "Kon",
      responsible_email: "kon@ime.usp.br",
      responsible_phone: "12332123",
      created_at: "2017-10-18T15:50:59.238Z",
      updated_at: "2017-10-18T15:50:59.238Z"
    }.to_json

    r = {
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

    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=S%C3%A3o%20Paulo&language=en&sensor=false").
      with{|request| not request.headers.blank?}.to_return(status: 200, body: r, headers: {})

    r = {}.to_json
    send_data_url = "http://localhost:8000/adaptor/components/92932hi/data"
    stub_request(:post, send_data_url).
      with{|request| not request.headers.blank?}.to_return(status: 200, body: r, headers: {})

      id = FactoryGirl.create(:platform).id
      Sidekiq::Testing.inline! do
        old_count = Initiative.count
        expect(old_count).to eq(0)
        InitiativeRegistrationWorker.new.perform(body, id)
        expect(Initiative.count).not_to eq(old_count)

        old_count = Initiative.count
        InitiativeRegistrationWorker.new.perform(body, id)
        expect(Initiative.count).to eq(old_count)
      end
    end
  end
end
