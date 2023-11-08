FactoryBot.define do
  factory :member do
    id { 1 }
    last_name { "nomu" }
    first_name { "sho" }
    email { "email@example.com" }
    password { "password" }
  end
end
