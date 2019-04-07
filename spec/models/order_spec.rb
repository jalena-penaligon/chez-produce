require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'relationships' do
    it { should have_many :order_items }
    it { should have_many(:items).through(:order_items) }
    it { should belong_to :user }
  end

  describe 'class methods' do
    it '.top_orders finds top orders' do
      order_1 = create(:shipped_order)
      order_2 = create(:shipped_order)
      order_3 = create(:shipped_order)
      order_4 = create(:shipped_order)

      order_item_1 = create(:fulfilled_order_item, order: order_1, order_price: 3.0, order_quantity: 6, created_at: 6.days.ago, updated_at: 3.days.ago)
      order_item_2 = create(:fulfilled_order_item, order: order_2, order_price: 4.5, order_quantity: 2, created_at: 6.days.ago, updated_at: 1.days.ago)
      order_item_3 = create(:fulfilled_order_item, order: order_3, order_price: 6.0, order_quantity: 1, created_at: 6.days.ago, updated_at: 4.days.ago)
      order_item_4 = create(:fulfilled_order_item, order: order_4, order_price: 10.0, order_quantity: 5, created_at: 6.days.ago, updated_at: 5.days.ago)

      expect(Order.top_orders).to eq([order_1, order_4, order_2])

    end
    # it 'can calc 'do
    #   user = create(:user)
    #   merchant_1 = create(:merchant)
    #   merchant_2 = create(:merchant)
    #   item_1 = create(:item, user: merchant_1)
    #   item_2 = create(:item, user: merchant_2)
    #   order = create(:order, user: user)
    #   create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1)
    #   create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1)
    #   order = create(:packaged_order, user: user)
    #   oi_1 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 1, order_quantity: 1, created_at: 3.5.days.ago, updated_at: 1.days.ago)
    #   oi_2 = create(:fulfilled_order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: 4.5.days.ago, updated_at: 1.days.ago)
    #
    #   actual = Order.fulfillment_time(item_1)
    #   expect(actual).to eq(2.5)
    # end
  end

end
