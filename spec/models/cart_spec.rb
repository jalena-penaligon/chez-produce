require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({"1" => 2, "2" => 1}) }
  describe "#total_count" do
    it "counts number of items in a cart" do

      expect(subject.total_count).to eq(3)
    end

    it "returns 0 if cart is empty" do
      cart = Cart.new({})

      expect(cart.total_count).to eq(0)
    end
  end

  describe "#find_item" do
    it "finds an item by its ID" do
      item_1 = create(:item, id: 1)
      item_2 = create(:item, id: 2)

      expect(subject.find_item(subject.contents.first)).to eq(item_1)
    end
  end

  describe "#item_subtotal" do
    it "calculates an items subtotal" do
      item_1 = create(:item, id: 1, current_price: 3.0)

      expect(subject.item_subtotal(item_1)).to eq(6.0)
    end
  end

  describe "#total_cost" do
    it "calculates a carts total cost" do
      item_1 = create(:item, id: 1, current_price: 3.0)
      item_2 = create(:item, id: 2, current_price: 4.5)

      expect(subject.total_cost).to eq(10.50)
    end
  end
end
