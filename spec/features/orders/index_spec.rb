require 'rails_helper'

RSpec.describe "As a registered user" do

  before :each do
    @user = create(:user)

    @merchant_1, @merchant_2 = create_list(:merchant, 2)

    @item_1 = create(:item, user: @merchant_1)
    @item_2 = create(:item, user: @merchant_2)

    @order_1 = create(:shipped_order, user: @user)
    create(:fulfilled_order_item, order: @order_1, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    create(:fulfilled_order_item, order: @order_1, item: @item_2, order_price: 2, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)

    @order_2 = create(:packaged_order, user: @user)
    create(:fulfilled_order_item, order: @order_2, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    create(:fulfilled_order_item, order: @order_2, item: @item_2, order_price: 2, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
  end

  describe "When I visit my Profile Orders page, /profile/orders" do
    it "I see every order I've made, which includes order's details" do

      visit profile_orders_path(@user)

      within "#order-info-#{@order_1.id}" do
        expect(page).to have_content(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content(@order_1.updated_at)
        expect(page).to have_content(@order_1.status)
        expect(page).to have_content('Total Quantity: 2')
        expect(page).to have_content('Total Price: $3.00')
      end

      within "#order-info-#{@order_2.id}" do
        expect(page).to have_content(@order_2.id)
        expect(page).to have_content(@order_2.created_at)
        expect(page).to have_content(@order_2.updated_at)
        expect(page).to have_content(@order_2.status)
        expect(page).to have_content('Total Quantity: 2')
        expect(page).to have_content('Total Price: $3.00')
      end

      click_on "#{@order_1.id}"
      expect(current_path).to eq(profile_order_path(@user, @order_1))
    end
  end
end
