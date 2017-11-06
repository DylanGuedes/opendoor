FactoryGirl.define do
  factory :air_quality do
    worker_uuid 'asdf1234'
    worker AirQuality.workers[:cetesb_gatherer_worker]
    uuid 'asdf1234'
    region 'sao-paulo'
    lat '-23'
    lon '-25'
    status AirQuality.steps[:not_registered]
    association :platform, factory: :platform, strategy: :build
  end
end
