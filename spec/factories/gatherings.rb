FactoryGirl.define do
  factory :gathering do
    name "MyString"
    description "MyString"
    date "2015-07-23"
    user
    group
  end
end
