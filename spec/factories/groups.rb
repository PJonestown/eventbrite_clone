FactoryGirl.define do
  factory :group do
    name 'Thailand ruby group'
    owner_id 1

    factory :other_group do
      name 'Boston ruby'
    end

    factory :invalid_group do
      name ''
    end
  end
end
