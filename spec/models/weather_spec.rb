require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Weather, type: :model do
  describe 'attributes' do

    before do
      @platform = FactoryGirl.create(:platform)
    end

    let(:attrs) { FactoryGirl.attributes_for(:weather, platform_id: @platform.id) }

    context 'with valid attrs' do
      subject { Weather.new(attrs) }

      it { is_expected.to be_valid }
    end

    context 'with invalid attrs' do
      it 'needs .lat and .lon attrs' do
        attrs[:lat] = nil
        attrs[:lon] = nil
        expect(Weather.new(attrs)).not_to be_valid
      end

      it 'needs .worker_uuid attr' do
        attrs[:worker_uuid] = nil
        expect(Weather.new(attrs)).not_to be_valid
      end

      it 'needs .platform attr' do
        attrs[:platform_id] = nil
        expect(Weather.new(attrs)).not_to be_valid
      end

      it 'needs equal .identifier_attr and .worker_uuid' do
        attrs[:worker_uuid] = 'otherthing'
        expect(Weather.new(attrs)).not_to be_valid
        attrs[:worker_uuid] = attrs[Weather.identifier_attr]
        expect(Weather.new(attrs)).to be_valid
      end
    end
  end

  describe "registration in the platform" do
    before do
      @platform = FactoryGirl.create(:platform)
      @wt = FactoryGirl.create(:weather, platform: @platform)
    end

    it 'ensure capabilities exist' do
      soft_stub_resource_registration('asdf1234')
      soft_stub_resource_data('asdf1234')
      mystub = soft_stub_capabilities
      @wt.fetch_or_register
      expect(mystub).to have_been_requested.times(1)
    end

    it 'correctly register resources' do
      ssrr = soft_stub_resource_registration('asdf1234')
      ssrd = soft_stub_resource_data('asdf1234')
      ssrds = soft_stub_resource_data_sending('asdf1234')
      ssc = soft_stub_capabilities

      @wt.fetch_or_register
      expect(@wt.uuid).not_to eq(nil)

      new_data = {
        temperature: [{value: 10, timestamp: Time.now}]
      }

      expect(ssrds).to have_been_requested.times(0)
      @wt.send_data(new_data)
      expect(ssrds).to have_been_requested.times(1)
    end
  end

  describe '#equal_to_unique_attr?' do
    before do
      @platform = FactoryGirl.create(:platform)
      @weather = FactoryGirl.create(:weather, platform_id: @platform.id)
    end

    subject { @weather.equal_to_unique_attr? }
    it { is_expected.to be_truthy }

    it 'unique_attr == worker_uuid?' do
      @weather.worker_uuid = 'asdf1234'
      expect(@weather).not_to be_valid
      expect(@weather.equal_to_unique_attr?).not_to be_truthy
    end
  end

  describe 'Weather#mount_data_from' do
    let(:entry) { FactoryGirl.attributes_for(:weather) }

    subject { Weather.mount_data_from(entry) }

    it '#capabilities are keys' do
      capabilities = Weather.capabilities.map{|x| x[:title].to_sym}
      expect(subject.keys).to match_array(capabilities)
    end
  end
end
