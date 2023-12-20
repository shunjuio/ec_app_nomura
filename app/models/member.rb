class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates :first_name, { presence: true }
  validates :last_name, { presence: true }
  validates :email, { uniqueness: true, presence: true }
  validates :password, { presence: true }
end
