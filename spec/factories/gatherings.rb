FactoryGirl.define do
  factory :gathering do
    name "MyString"
    description "MyString"
    date "2015-07-23"
    approved true
    creator_id 1
    group_id 1

    factory :invalid_gathering do
      name ''
    end

    factory :unapproved_gathering do
      name 'something'
      approved false
    end
  end
end
