class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :carts
  has_many :orders
  validates :first_name, { presence: true }
  validates :last_name, { presence: true }
  validates :email, { uniqueness: true, presence: true }
  validates :password, { presence: true }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "current_sign_in_at", "current_sign_in_ip", "email", "encrypted_password", "first_name", "id", "id_value", "last_name", "last_sign_in_at", "last_sign_in_ip", "remember_created_at", "reset_password_sent_at", "reset_password_token", "sign_in_count", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["carts", "orders"]
  end
end
