FactoryBot.define do
  factory :user do
    name { "リハ太郎" }
    email { "reha1@example.com" }
    password { "foovar" }
    password_confirmation { "foovar" }
  end
end
