class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def fulfilled?
    fulfilled = true
  end

  def self.fulfillment_time(item)
    joins(:item)
    .select('items.*, avg(order_items.updated_at - order_items.created_at) as avg_time')
    .group('items.id')
    .where("items.id = ?", item.id)
    .limit(1)
      # select items.id, avg(order_items.updated_at - order_items.created_at)as avg_time
      # from order_items inner join items on order_items.item_id = items.id
      # where items.id = 71 group by items.id;
  end
end
# def self.average_item_fulfillment(item)
#   binding.pry
#   self.select("items.*, avg(order_items.updated_at - order_items.created_at) as avg_time")
#   .joins(:order_items)
#   .where("order_items.fulfilled = true")
#   .where("id = #{item}")
#   .group(:id)
#   .order(:id)
# end
