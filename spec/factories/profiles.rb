FactoryGirl.define do
  factory :profile do
    location "New York"
    user nil

    factory :other_profile do
      location 'Chicago'
    end

    factory :invalid_profile do
      location nil
    end
  end
end
