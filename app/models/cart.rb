class Cart < ApplicationRecord
  belongs_to :product
  belongs_to :member

  validates :quantity, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "member_id", "product_id", "quantity", "updated_at"]
  end
end
