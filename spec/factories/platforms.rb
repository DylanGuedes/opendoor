FactoryGirl.define do
  factory :platform do
    url 'myniceurl.com'
    description 'myniceplatform'
  end
  factory :parser do
  end
  factory :collector do
    trait :unpopulated do
      resource []
    end
  end
end
