class User < ApplicationRecord
  validates_presence_of :password
  validates :email, presence: true, uniqueness: true
  has_many :orders
  has_many :items

  has_secure_password


end
