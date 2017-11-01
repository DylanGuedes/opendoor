require 'rails_helper'
require 'sidekiq/testing'
require 'helpers/interscity_mocks'
require 'helpers/geocoder_mocks'

RSpec.configure do |c|
  c.include InterscityMocks
  c.include GeocoderMocks
end

RSpec.describe InitiativeRegistrationWorker, type: :worker do
  describe 'normal job scheduling' do
    it 'should create resources and not duplicate registration' do
      soft_stub_capabilities
      soft_stub_resource_registration('asdf1234')
      stub_sao_paulo_coordinates
      soft_stub_resource_data_sending('asdf1234')

      body_example = {
        name: "IME",
        institution: "IME",
        address: "Rua do Matao 1010",
        city: "São Paulo",
        state: "SP",
        responsible: "Professor",
        responsible_email: "professor@ime.usp.br",
        responsible_phone: "12332123",
        created_at: "2017-10-18T15:50:59.238Z",
        updated_at: "2017-10-18T15:50:59.238Z"
      }

      id = FactoryGirl.create(:platform).id
      Sidekiq::Testing.inline! do
        old_count = Initiative.count
        expect(old_count).to eq(0)
        InitiativeRegistrationWorker.new.perform(body_example, id)
        expect(Initiative.count).not_to eq(old_count)

        old_count = Initiative.count
        InitiativeRegistrationWorker.new.perform(body_example, id)
        expect(Initiative.count).to eq(old_count)
      end
    end
  end
end
