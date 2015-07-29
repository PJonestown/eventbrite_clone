FactoryGirl.define do
  factory :join_request do
    message "Please let me in!"

    factory :invalid_join_request do
      message nil
    end
  end
end
