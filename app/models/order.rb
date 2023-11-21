class Order < ApplicationRecord
  belongs_to :member
  has_many :order_products

  validates :postal_code, presence: true
  validates :shipping_address, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "id_value", "member_id", "postage", "amount_billed", "payment_method", "shipping_address", "postal_code", "created_at", "updated_at", "purchaser_last_name", "purchaser_first_name", "purchaser_email"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["member", "order_products"]
  end
end
