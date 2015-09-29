FactoryGirl.define do
  factory :event do
    name "Ruby meetup"
    description "Free pizza and beer!"
    date Date.today + 3.days

    factory :another_event do
      name "Backroom 100nl poker meetup"
    end

    factory :invalid_event do
      name ''
    end
  end
end
