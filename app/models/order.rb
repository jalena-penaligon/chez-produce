class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  enum status: ['pending', 'packaged', 'shipped', 'cancelled']

  def self.top_orders
    joins(:order_items)
    .select('orders.*, sum(order_items.order_quantity) as total_quantity')
    .where(status: 2)
    .group(:id)
    .order('total_quantity DESC')
    .limit(3)
  end

  # def one_day
  #   3600*24
  # end
  #
  # def self.fulfillment_time(item)
  #   self.joins(:order_items)
  #   .select('avg(order_items.updated_at - order_items.created_at)as avg_time')
  #   .group(:item_id)
  #   .where('order_items.item_id = item.id')
  #   .pluck('avg(order_items.updated_at - order_items.created_at)as avg_time')
  # end

  def total_quantity
    order_items.sum(:order_quantity)
  end

  def grand_total
    order_items.sum(:order_price)
  end
end
