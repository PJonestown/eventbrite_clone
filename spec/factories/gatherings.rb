FactoryGirl.define do
  factory :gathering do
    name "MyString"
    description "MyString"
    date Date.today + 4.days
    approved true
    creator_id 1
    group_id 1

    factory :other_gathering do
      name 'another'
    end

    factory :invalid_gathering do
      name ''
    end

    factory :unapproved_gathering do
      name 'something'
      approved false
    end
  end
end
