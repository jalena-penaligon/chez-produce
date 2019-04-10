require 'rails_helper'
RSpec.describe 'As a merchant' do
  before :each do
    @user = create(:user)
    @user_2 = create(:user)
    @merchant_1, @merchant_2 = create_list(:merchant, 2)
    @item_1 = create(:item, user: @merchant_1, inventory: 1)
    @item_2 = create(:item, user: @merchant_2, inventory: 1)
    @item_3 = create(:item, user: @merchant_1, inventory: 0)
    # shipped order, cannot be cancelled
    @order_1 = create(:shipped_order, user: @user)
    @order_item_1 = create(:fulfilled_order_item, order: @order_1, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    @order_item_2 = create(:fulfilled_order_item, order: @order_1, item: @item_2, order_price: 2, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)

    @order_2 = create(:shipped_order, user: @user_2)
    @order_item_3 = create(:fulfilled_order_item, order: @order_2, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    # pending order, none fulfilled
    @order_3 = create(:order, user: @user_2)
    @order_item_4 = create(:order_item, order: @order_3, item: @item_1, order_price: 1, order_quantity: 2)
    @order_item_5 = create(:order_item, order: @order_3, item: @item_2, order_price: 2, order_quantity: 1)
    # pending order, partially fulfilled
    @order_4 = create(:order, user: @user)
    @order_item_6 = create(:order_item, order: @order_4, item: @item_1, order_price: 1, order_quantity: 1)
    @order_item_7 = create(:fulfilled_order_item, order: @order_4, item: @item_2, order_price: 2, order_quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)
    # packaged order
    @order_5 = create(:packaged_order, user: @user)
    @order_item_8 = create(:fulfilled_order_item, order: @order_5, item: @item_2, order_price: 1, order_quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)
    @order_item_9 = create(:fulfilled_order_item, order: @order_5, item: @item_3, order_price: 2, order_quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)
    # pending order, none fulfilled
    @order_6 = create(:order, user: @user_2)
    @order_item_10 = create(:order_item, order: @order_6, item: @item_1, order_price: 1, order_quantity: 1)
    @order_item_11 = create(:order_item, order: @order_6, item: @item_2, order_price: 2, order_quantity: 1)

end
  describe 'When I visit an order show page from my dashboard' do
    it 'i can fulfill an order item belonging to me' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
      visit dashboard_order_path(@order_6)

      expect(page).to have_content(@item_1.inventory)
      expect(@item_1.inventory).to eq(1)

      within ".fulfill-item-#{@order_item_10.id}" do
        click_on "Fulfill"
      end

      expect(current_path).to eq(dashboard_order_path(@order_6))
      expect(page).to have_content("Status: fulfilled")
      expect(page).to have_content("Current Inventory: 0")
      expect(page).to have_content("You have successfully fulfilled this order")
    end

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

    it 'i can not fulfill an order item belonging to me without sufficient inventory' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
      visit dashboard_order_path(@order_3)

      expect(current_path).to eq(dashboard_order_path(@order_3))


      expect(page).to have_content("Status: not fulfilled")
      expect(page).to have_content("You do not have enough inventory to fulfill this order")
    end

    it 'when all items in the order have been fulfilled, the order status changes to packaged' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)


      visit dashboard_order_path(@order_5)

      within "#item-info-#{@item_3.id}" do
        expect(page).to have_content("Status: fulfilled")
      end

      expect(page).to have_content("Order Status: packaged")
    end
  end
end
