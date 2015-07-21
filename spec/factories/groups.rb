FactoryGirl.define do
  factory :group do
    name 'Thailand ruby group'

    factory :other_group do
      name 'Boston ruby'
    end

    factory :invalid_group do
      name ''
    end
  end
end
