class Product < ApplicationRecord
  has_many :carts
  validates :name, { presence: true }
  validates :price, { presence: true }
  validates :alcohol, { presence: true }
  validates :image_path, { presence: true }
  validates :material, { presence: true }
  validates :product_area, { presence: true }
end
