class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents
  end

  def total_count
    if @contents != nil
      @contents.values.sum
    end
  end

  def find_item(id)
    Item.find(id.first.to_i)
  end

  def item_subtotal(item)
    @contents[item.id.to_s] * item.current_price
  end

  def total_cost
    cost = 0
    @contents.each do |id|
      item = find_item(id)
      subtotal = item_subtotal(item)
      cost += subtotal
    end
    cost
  end
end
