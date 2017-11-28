require 'sidekiq/testing'
require 'helpers/interscity_mocks'
require 'helpers/geocoder_mocks'

RSpec.describe CatracalivreGathererWorker, type: :worker do
  describe '#perform' do
    before do
      @platform = FactoryGirl.create(:platform)
    end

    context 'invalid worker' do
      subject { CatracalivreGathererWorker.new.perform(0) }
      it 'raises error if invalid platform' do
        expect{subject}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'valid worker' do
      subject { CatracalivreGathererWorker.new.perform(@platform.id) }
      it 'call desired methods withou errors' do
        soft_stub_catracalivre_request
        soft_stub_capabilities
        soft_stub_resource_registration('asdf1234')
        soft_stub_resource_data_sending('asdf1234')
        expect(News.count).to eq(0)
        subject
        expect(News.count).to eq(1)
        subject
        expect(News.count).to eq(1)
        expect { subject }.not_to raise_error
      end
    end
  end
end
