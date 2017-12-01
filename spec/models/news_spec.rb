require 'rails_helper'
require 'webmock/rspec'

RSpec.describe News, type: :model do
  describe 'invalid params' do
    it 'requires a platform' do
      attrs = FactoryGirl.attributes_for(:news, platform_id: nil)
      news = News.new(attrs)
      expect(news).not_to be_valid
    end
  end

  describe 'valid params' do
    it 'works well' do
      platform = FactoryGirl.create(:platform)
      attrs = FactoryGirl.attributes_for(:news, platform_id: platform.id)
      news = News.new(attrs)
      expect(news).to be_valid
    end
  end

  describe 'registration in the platform' do
    before do
      @news = FactoryGirl.create(:news)
    end

    it 'ensure capabilities exist' do
      ssrd = soft_stub_resource_data('asdf1234')
      ssc = soft_stub_capabilities
      @news.fetch_or_register
      expect(ssrd).to have_been_requested.times(1)
      expect(ssc).to have_been_requested.times(1)
    end

    it 'correctly register resources' do
      ssrd = soft_stub_resource_data('asdf1234')
      ssrr = soft_stub_resource_registration('asdf1234')
      ssrds = soft_stub_resource_data_sending('asdf1234')
      ssc = soft_stub_capabilities

      @news.fetch_or_register
      expect(@news.uuid).not_to eq(nil)

      new_data = {
        title: [{value: 'new title', timestamp: Time.now}]
      }
      expect(ssrds).to have_been_requested.times(0)
      @news.send_data(new_data)
      expect(ssrds).to have_been_requested.times(1)
    end

  end

end
