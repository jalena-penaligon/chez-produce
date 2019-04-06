require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before :each do
    @user = create(:user)
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, user: @merchant_1)
    @item_2 = create(:item, user: @merchant_2)
    @order = create(:order, user: @user)
    create(:order_item, order: @order, item: @item_1, order_price: 1, order_quantity: 1)
    create(:order_item, order: @order, item: @item_2, order_price: 2, order_quantity: 1)
    @order = create(:packaged_order, user: @user)
    @oi_1 = create(:fulfilled_order_item, order: @order, item: @item_1, order_price: 1, order_quantity: 1, created_at: 3.5.days.ago, updated_at: 1.minutes.ago)
    @oi_2 = create(:fulfilled_order_item, order: @order, item: @item_2, order_price: 2, order_quantity: 1, created_at: 4.5.days.ago, updated_at: 1.minutes.ago)
  end
  describe 'relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end

  describe 'instance methods' do
    xit 'can calc avg fulfillment time' do
      actual = @oi_1.fulfillment_time(@item_1.id)
      expect(actual).to eq(4)
    end
    xit 'can identify fulfilled order items' do
      actual = @oi_1.fulfilled?
      expect(actual).to eq(true)
    end
  end
end
