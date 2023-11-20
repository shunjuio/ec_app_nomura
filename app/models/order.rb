class Order < ApplicationRecord
  belongs_to :member
  has_many :order_products

  validates :postal_code, presence: true
  validates :shipping_address, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["amount_billed", "created_at", "id", "id_value", "member_id", "payment_method", "postage", "postal_code", "purchaser_email", "purchaser_first_name", "purchaser_last_name", "shipping_address", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["member", "order_products"]
  end
end
