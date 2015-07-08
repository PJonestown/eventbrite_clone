FactoryGirl.define do
  factory :user do
    username "virginia_woolf"

    factory :invalid_user do
      username ''
    end
  end
end
