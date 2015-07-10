FactoryGirl.define do
  factory :event do
    title "Ruby meetup"
    description "Free pizza and beer!"
    date "2015-07-09"
    # association :user

    factory :invalid_event do
      title ''
    end
  end
end
