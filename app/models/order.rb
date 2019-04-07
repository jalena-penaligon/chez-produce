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

  def total_quantity
    order_items.sum(:order_quantity)
  end

  def grand_total
    order_items.sum(:order_price)
  end
  # 
  # def self.subtotal(item)
  #   joins(:order_items)
  #   .select("order.*, sum(order_price * order_quantity) as subtotal")
  #   .group(:id)
  #   .where("order_items.item_id = #{item.id}")
  #   .pluck("sum(order_price * order_quantity) as subtotal")
  # end
end
