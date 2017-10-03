FactoryGirl.define do
  factory :platform do
    url 'myniceurl.com'
    description 'myniceplatform'
  end
  factory :collector do
    trait :unpopulated do
      resource []
    end
  end
  factory :parser do
  end
end
