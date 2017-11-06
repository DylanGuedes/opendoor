FactoryGirl.define do
  factory :bike_station do
    worker_uuid 'asdf1234'
    worker BikeStation.workers[:citybik_gatherer_worker]
    uuid 'asdf1234'
    bike_station_uuid 'bike_station_uuid'
    lon '-23'
    lat '-25'
    status BikeStation.steps[:not_registered]
    association :platform, factory: :platform, strategy: :build
  end
end
