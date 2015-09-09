FactoryGirl.define do
  factory :profile do
    location "New York"
    user nil

    factory :invalid_profile do
      location nil
    end
  end
end
