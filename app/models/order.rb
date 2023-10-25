class Order < ApplicationRecord
  belongs_to :member
  has_many :order_products

  validates :postal_code, presence: true
  validates :shipping_address, presence: true
end
