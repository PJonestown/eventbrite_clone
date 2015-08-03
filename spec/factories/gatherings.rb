FactoryGirl.define do
  factory :gathering do
    name "MyString"
    description "MyString"
    date "2015-07-23"
    approved true

    factory :invalid_gathering do
      name ''
    end

    factory :unapproved_gathering do
      name 'something'
      approved false
    end
  end
end
