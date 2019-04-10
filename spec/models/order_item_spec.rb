require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before :each do
    @user = create(:user)
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, user: @merchant_1, name: "Zucchini")
    @item_2 = create(:item, user: @merchant_2)
    @item_3 = create(:item, user: @merchant_2)
    @order = create(:order, user: @user)
    create(:order_item, order: @order, item: @item_1, order_price: 1, order_quantity: 1)
    create(:order_item, order: @order, item: @item_2, order_price: 2, order_quantity: 1)
    @order = create(:packaged_order, user: @user)
    @oi_1 = create(:fulfilled_order_item, order: @order, item: @item_1, order_price: 1, order_quantity: 1, created_at: 3.5.days.ago, updated_at: 1.days.ago)
    @oi_2 = create(:fulfilled_order_item, order: @order, item: @item_2, order_price: 2, order_quantity: 1, created_at: 4.5.days.ago, updated_at: 1.days.ago)
    @oi_3 = create(:fulfilled_order_item, order: @order, item: @item_3, order_price: 2, order_quantity: 1, created_at: 4.5.days.ago, updated_at: 4.5.days.ago)
  end
  describe 'relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end

  describe 'class methods' do
    it 'can calc avg fulfillment_time' do
      actual = OrderItem.fulfillment_time(@item_1)
      expect(actual).to eq(1.25)
    end
    it 'can return a zero from the avg fulfillment_time' do
      actual = OrderItem.fulfillment_time(@item_3)
      expect(actual).to eq(0)
    end
    it 'can find an item' do
      actual = OrderItem.find_item(@item_1)
      expect(actual.count).to eq(2)
    end
    it 'can sum an array of date differences' do
      array = OrderItem.find_item(@item_1)
      actual = OrderItem.map_it(array)
      expect(actual.round(2)).to eq(216000.00)
    end
  end
end
