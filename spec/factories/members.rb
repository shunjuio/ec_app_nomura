FactoryBot.define do
  factory :member do
    id { 1 }
    last_name { "hoge" }
    first_name { "fuga" }
    email { "email@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
