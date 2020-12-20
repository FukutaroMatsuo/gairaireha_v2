FactoryBot.define do
  factory :reha do
    day { "2020-10-11" }
    association :user
    association :patient
  end
end