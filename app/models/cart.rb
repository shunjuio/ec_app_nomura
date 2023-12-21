class Cart < ApplicationRecord
  belongs_to :product
  belongs_to :member

  validates :quantity, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w(id id_value product_id member_id quantity created_at updated_at)
  end
end
