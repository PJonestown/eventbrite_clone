FactoryGirl.define do
  factory :event do
    title "Ruby meetup"
    description "Free pizza and beer!"
    date "2015-07-09"
    # association :user

    factory :another_event do
      title "Backroom 100nl poker meetup"
    end

    factory :invalid_event do
      title ''
    end

    factory :test_event do
      creator_id 1
    end
  end
end
