class Member < ApplicationRecord
  has_many :carts
  validates :first_name, { presence: true }
  validates :last_name, { presence: true }
  validates :email, { uniqueness: true, presence: true }
  validates :password, { presence: true }
end
