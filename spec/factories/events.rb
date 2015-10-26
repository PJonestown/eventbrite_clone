FactoryGirl.define do
  factory :event do
    name "Ruby meetup"
    description "Free pizza and beer!"
    date Time.zone.now + 3.months

    factory :another_event do
      name "Backroom 100nl poker meetup"
    end

    factory :invalid_event do
      name ''
    end
  end
end
