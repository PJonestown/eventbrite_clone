FactoryGirl.define do
  factory :group do
    name 'Thailand ruby group'
    description 'Free beer'
    owner_id 1
    category_id 1
    is_private false

    factory :other_group do
      name 'Boston ruby'
    end

    factory :private_group do
      name 'Super Secret Club'
    end

    factory :invalid_group do
      name ''
    end
  end
end
