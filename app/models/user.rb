class User < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zipcode
  validates :email, presence: true, uniqueness: true
  has_many :orders
  has_many :items
  validates_presence_of :password_digest
  validates_confirmation_of :password

  has_secure_password

  enum role: ['user', 'merchant', 'admin']
end
