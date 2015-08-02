FactoryGirl.define do
  factory :gathering do
    name "MyString"
    description "MyString"
    date "2015-07-23"
    approved false

    factory :invalid_gathering do
      name ''
    end
  end
end
