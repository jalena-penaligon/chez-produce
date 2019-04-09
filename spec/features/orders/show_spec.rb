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

    @order_2 = create(:order, user: @user)
    @order_item_3 = create(:order_item, order: @order_2, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    @order_item_4 = create(:order_item, order: @order_2, item: @item_2, order_price: 2, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
  end

  describe "As a registered user" do
    it "I see information about the order including each item and it's details" do

      visit profile_order_path(@user, @order_1)

      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_1.created_at)
      expect(page).to have_content(@order_1.updated_at)
      expect(page).to have_content(@order_1.status.capitalize)
      expect(page).to have_content('Total Quantity: 2')
      expect(page).to have_content('Total Price: $3.00')

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@order_item_1.order_quantity)
      expect(page).to have_content(@order_item_1.order_price)

      within "#item-info-#{@order_item_1.id}" do
        expect(page).to have_content("Subtotal: $1.00")
      end
      within "#item-info-#{@order_item_2.id}" do
        expect(page).to have_content("Subtotal: $2.00")
      end
      expect(page).to have_content(@order_1.total_quantity)
      expect(page).to have_content(@order_1.grand_total)
    end
  end
  describe "As a merchant" do
    it "shows only the order page with items belonging to the merchant" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
      visit dashboard_order_path(@order_1)

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.street_address)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@order_item_1.order_price)
      expect(page).to have_content(@order_item_1.order_quantity)
      expect(page).to have_css("img[src*='#{@item_1.image}']")
      within "#item-info-#{@item_1.id}" do
        expect(page).to_not have_content(@item_2.name)
      end
      click_on "#{@item_1.name}"
      expect(current_path).to eq(item_path(@item_1))
    end
  end

  describe 'As a registered user' do
    it 'allows you to cancel pending orders' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_order_path(@user, @order_1)
      expect(page).to_not have_button("Cancel Order")

      visit profile_order_path(@user, @order_2)

      click_on("Cancel Order")
      order_2 = Order.find(@order_2.id)
      order_item_3 = OrderItem.find(@order_item_3.id)
      order_item_4 = OrderItem.find(@order_item_4.id)

      expect(current_path).to eq(profile_path)

      expect(order_2.status).to eq("cancelled")
      expect(order_item_3.fulfilled).to eq(false)
      expect(order_item_3.fulfilled).to eq(false)
    end
  end
end
