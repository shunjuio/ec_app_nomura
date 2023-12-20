FactoryBot.define do
  factory :order do
    id { 1 }
    postal_code { '1234567' }
    shipping_address { '東京都渋谷区' }
  end
end
