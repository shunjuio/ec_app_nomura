class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "order_id", "product_id", "quantity", "updated_at"]
  end
end
