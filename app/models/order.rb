class Order < ApplicationRecord
  belongs_to :member
  has_many :order_products, dependent: :destroy
  enum payment_method: { "クレジットカード": 1, "電子マネー": 2, "代金引換": 3, "請求書払": 4 }

  validates :postal_code, presence: true
  validates :shipping_address, presence: true
end
