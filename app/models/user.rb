class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :carted_products

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :name, length: {minimum: 2}
end
