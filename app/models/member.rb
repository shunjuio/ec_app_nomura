class Member < ApplicationRecord
  has_many :carts
  validates :email, { uniqueness: true }
end
