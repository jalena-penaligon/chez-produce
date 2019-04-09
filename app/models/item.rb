class Item < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :user
  validates_presence_of :name

  def self.active_items_by_merchant
        select('users.name as merchant_name, items.*')
            .joins(:user)
            .where('users.role': 1, active:true, "users.active": true)
            .entries
  end

  def self.items_sold(limit = 5, order = 'asc')
       Item.select("items.*, sum(order_items.order_quantity) as items_qty")
       .joins(:order_items)
       .where('order_items.fulfilled = true')
       .group(:id)
       .order("items_qty #{order}")
       .limit(limit)
  end

  def not_ordered?
    order_items.first == nil
  end

  def in_stock?(order_item)
    order_item = OrderItem.find(order_item.id)
    if self.inventory >= order_item.order_quantity
      true
    end
  end

end
