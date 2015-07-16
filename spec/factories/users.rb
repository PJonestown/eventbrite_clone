FactoryGirl.define do
  factory :user do
    username 'virginia_woolf'

    factory :invalid_user do
      username ''
    end

    factory :other_user do
      username 'pig_bodine'
    end
  end
end
