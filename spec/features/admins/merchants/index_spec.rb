require 'rails_helper'

RSpec.describe "Admin merchant index" do
  describe "as an admin, when I visit the merchant index page" do
    it "displays all merchant info" do
      user = create(:user)
      admin = create(:admin)
      merchant = create(:merchant)

      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)

      order = create(:order, user: user)
      order_item_1 = create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1)
      order_item_2 = create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit merchants_path

      click_on "#{merchant.name}"
      expect(current_path).to eq(admin_merchant_path(merchant))

      expect(page).to have_content(merchant.name)
      expect(page).to have_content(merchant.street_address)
      expect(page).to have_content(merchant.city)
      expect(page).to have_content(merchant.state)
      expect(page).to have_content(merchant.zipcode)
      expect(page).to have_content(merchant.email)

      within "#merchant-orders" do
        expect(page).to have_link(order.id)
        expect(page).to have_content(order.created_at)
        expect(page).to have_content(order_item_1.order_quantity)
        expect(page).to have_content("Subtotal: 1.0")

        expect(page).to have_content(order_item_2.order_quantity)
        expect(page).to have_content("Subtotal: 2.0")
      end
    end
  end
end
