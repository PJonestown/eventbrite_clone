FactoryGirl.define do
  factory :address do
    location 'New York'
    latitude 1.5
    longitude 1.5
    addressable_id 1
    addressable_type 'Group'

    factory :other_address do
      location 'Chicago'
    end

    factory :invalid_address do
      location ''
    end
  end
end
