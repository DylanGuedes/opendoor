FactoryGirl.define do
  factory :weather do
    worker_uuid 'saopaulo'
    worker AirQuality.workers[:cetesb_gatherer_worker]
    uuid 'asdf1234'
    region 'saopaulo'
    lat '-23'
    lon '-25'
    status AirQuality.steps[:not_registered]
    association :platform, factory: :platform, strategy: :build
  end
end
