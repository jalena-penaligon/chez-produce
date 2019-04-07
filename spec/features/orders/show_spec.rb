require 'rails_helper'

RSpec.describe "When I visit my order show page" do

  before :each do
    @user = create(:user)

    @merchant_1, @merchant_2 = create_list(:merchant, 2)

    @item_1 = create(:item, user: @merchant_1)
    @item_2 = create(:item, user: @merchant_2)

    @order_1 = create(:shipped_order, user: @user)
    @order_item_1 = create(:fulfilled_order_item, order: @order_1, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    @order_item_2 = create(:fulfilled_order_item, order: @order_1, item: @item_2, order_price: 2, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
  end

  describe "As a registered user" do
    it "I see information about the order including each item and it's details" do

      visit profile_order_path(@user, @order_1)

      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_1.created_at)
      expect(page).to have_content(@order_1.updated_at)
      expect(page).to have_content(@order_1.status)
      expect(page).to have_content('Total Quantity: 2')
      expect(page).to have_content('Total Price: 3')

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@order_item_1.order_quantity)
      expect(page).to have_content(@item_1.current_price)

      within "#item-info-#{@order_item_1.id}" do
        expect(page).to have_content("Subtotal: $1")
      end
      within "#item-info-#{@order_item_2.id}" do
        expect(page).to have_content("Subtotal: $2")
      end
      expect(page).to have_content(@order_1.total_quantity)
      expect(page).to have_content(@order_1.grand_total)

    end
  end

  describe "As a merchant" do
    it "shows only the order page with items belonging to the merchant" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
      visit profile_order_path(@merchant_1, @order_1)

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.street_address)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@order_item_1.current_price)
      expect(page).to have_content(@order_item_1.order_quantity)
      expect(page).to have_xpath('//img[@src="http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg"]') 

      expect(page).to_not have_content(@item_2.name)
    end
  end
end
