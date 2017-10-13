require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe CetesbGathererWorker, type: :worker do
  describe 'normal job scheduling' do
    it 'should create resources' do
      FactoryGirl.create(:platform)
      # id = Platform.all[0].id
      # puts "ID HERE #{id}"
      # puts "PLATFORM: #{Platform.find(id)}"
      # Sidekiq::Testing.inline! do
      #   expect {
      #     CetesbGathererWorker.perform_async(AirQuality.workers[:cetesb_gatherer_worker], id)
      #   }.to change(AirQuality.count, :size).by(1)
      # end
    end
  end
end
