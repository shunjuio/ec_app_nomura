FactoryBot.define do
  factory :cart do
    id { 1 }
    quantity { 2 }
    product_id { 1 }
    member_id { 1 }
  end
end
