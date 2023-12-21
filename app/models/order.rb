class Order < ApplicationRecord
  belongs_to :member
  has_many :order_products, dependent: :destroy

  validates :postal_code, presence: true
  validates :shipping_address, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id id_value member_id postage amount_billed payment_method
       shipping_address postal_code created_at updated_at purchaser_last_name
       purchaser_first_name purchaser_email]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[member order_products]
  end
end
