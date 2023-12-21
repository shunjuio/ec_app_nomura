class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def self.ransackable_attributes(_auth_object = nil)
    %w[id id_value product_id order_id quantity created_at updated_at]
  end
end
