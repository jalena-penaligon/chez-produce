require 'rails_helper'
RSpec.describe 'all users' do
  describe 'can visit an items show page' do
    it 'has info about the item' do
      merchant_1 = create(:merchant)
      item_1 = create(:item, user: merchant_1)
      user = create(:user)
      order = create(:shipped_order, user: user)
      order_item_1 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 3.0, order_quantity: 6, created_at: 5.days.ago, updated_at: 1.days.ago)
      order_item_2 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 4.5, order_quantity: 2, created_at: 5.days.ago, updated_at: 2.days.ago)
      order_item_3 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 6.0, order_quantity: 1, created_at: 5.days.ago, updated_at: 3.days.ago)
      order_item_4 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 10.0, order_quantity: 5, created_at: 5.days.ago, updated_at: 4.days.ago)
      order_item_5 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 3.0, order_quantity: 2, created_at: 5.days.ago, updated_at: 5.days.ago)
      order_item_6 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 4.5, order_quantity: 1, created_at: 5.days.ago, updated_at: 3.days.ago)


      visit item_path(item_1)

      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.description)
      expect(page).to have_css("img[src*='#{item_1.image}']")
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(item_1.inventory)
      expect(page).to have_content(item_1.current_price)
      expect(page).to have_content("Add to Cart")

      # expect(page).to have_content("Average Fulfillment Time: 3")
    end
  end
end
