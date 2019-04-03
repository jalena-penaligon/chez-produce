class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  enum status: ['pending', 'packaged', 'shipped', 'cancelled']
end
