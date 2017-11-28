FactoryGirl.define do
  factory :news do
    worker_uuid "asdf1234"
    worker News.workers[:catracalivre_gatherer_worker]
    uuid "asdf1234"
    post_id 1
    lat '-23'
    lon '-25'
    status News.steps[:not_registered]
    association :platform, factory: :platform, strategy: :build
  end
end
