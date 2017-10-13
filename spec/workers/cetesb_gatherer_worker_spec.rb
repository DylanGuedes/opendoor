require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe CetesbGathererWorker, type: :worker do
  describe 'normal job scheduling' do
    it 'should create resources' do
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
