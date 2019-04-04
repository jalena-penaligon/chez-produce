class User < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zipcode
  validates :email, presence: true, uniqueness: true
  has_many :orders
  has_many :items
  validates_presence_of :password_digest
  validates_confirmation_of :password

  has_secure_password

  enum role: ['user', 'merchant', 'admin']

  def self.active_merchants
    where(role: 1, active: true)
  end

end
