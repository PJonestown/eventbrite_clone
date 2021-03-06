FactoryGirl.define do
  factory :group do
    name 'Thailand ruby group'
    description 'Free beer'
    owner_id 1
    category_id 1
    is_private false
    restricted false

    factory :restricted_group do
      name 'Restricted group'
      restricted true
    end

    factory :other_group do
      name 'Boston ruby'
    end

    factory :private_group do
      name 'Super Secret Club'
      is_private true
    end

    factory :invalid_group do
      name ''
    end
  end
end
