class Product < ApplicationRecord
  has_many :carts, dependent: :destroy
  has_many :order_products, dependent: :destroy
  validates :name, { presence: true }
  validates :price, { presence: true }
  validates :alcohol, { presence: true }
  validates :image_path, { presence: true }
  validates :material, { presence: true }
  validates :product_area, { presence: true }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id id_value name price alcohol image_path material product_area created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[carts order_products]
  end
end
