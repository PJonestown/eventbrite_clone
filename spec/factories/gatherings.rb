FactoryGirl.define do
  factory :gathering do
    name "MyString"
    description "MyString"
    date Time.zone.today + 4.months
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
