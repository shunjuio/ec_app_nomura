class Product < ApplicationRecord
  has_many :carts
  has_many :order_products
  validates :name, { presence: true }
  validates :price, { presence: true }
  validates :alcohol, { presence: true }
  validates :image_path, { presence: true }
  validates :material, { presence: true }
  validates :product_area, { presence: true }

  def self.ransackable_attributes(auth_object = nil)
    ["alcohol", "created_at", "id", "id_value", "image_path", "material", "name", "price", "product_area", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["carts", "order_products"]
  end
end
