FactoryGirl.define do
  factory :profile do
    zipcode "MyString"
    user nil

    factory :invalid_profile do
      zipcode nil
    end
  end
end
