require 'rails_helper'

RSpec.describe "As a registered user" do

  before :each do
    @user = create(:user)

    @merchant_1, @merchant_2 = create_list(:merchant, 2)

    @item_1 = create(:item, user: @merchant_1)
    @item_2 = create(:item, user: @merchant_2)

    @order_1 = create(:shipped_order, user: @user)
    @order_item_1 = create(:fulfilled_order_item, order: @order_1, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    @order_item_2 = create(:fulfilled_order_item, order: @order_1, item: @item_2, order_price: 2, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
  end

  describe "When I visit my order show page" do
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
      save_and_open_page
    end
  end
end
