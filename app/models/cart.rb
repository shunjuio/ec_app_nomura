class Cart < ApplicationRecord
  belongs_to :product
  belongs_to :member

  validates :quantity, presence: true
end
