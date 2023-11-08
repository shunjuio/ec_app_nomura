FactoryBot.define do
  factory :product do
    id { 1 }
    name { "響" }
    price { 1700 }
    alcohol { "40%" }
    image_path { "/product_images/hibiki.png" }
    material { "molt" }
    product_area { "america" }
  end
end
