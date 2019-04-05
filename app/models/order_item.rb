class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def fulfilled?
    fulfilled = true
  end

  def fulfillment_time(item)
    # binding.pry
    if fulfilled?
      select('sum(updated_at - created_at)')
      .where("item_id = ?", item)
      # .group(:item_id)
    else
      'n/a'
    end
  end
end
