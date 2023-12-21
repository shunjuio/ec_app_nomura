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

  def self.ransackable_attributes(auth_object = nil)
    ['id', 'id_value', 'last_name', 'first_name', 'email', 'created_at', 'updated_at', 'encrypted_password', 'reset_password_token', 'reset_password_sent_at', 'remember_created_at', 'sign_in_count', 'current_sign_in_at', 'last_sign_in_at', 'current_sign_in_ip', 'last_sign_in_ip']
  end

  def self.ransackable_associations(auth_object = nil)
    ['carts', 'orders']
  end
end
