require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when I visit my items page /dashboard/items" do
    it "I see a link to add a new item to the system and I see each item I have already added to the system and it's information" do
      merchant = create(:merchant)
      item_1 = create(:item)
      item_2 = create(:item)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit '/dashboard/items'

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_link("Add New Item")

      within "#item-#{item_1.id}" do
        expect(page).to have_css("img[src*='#{item_1.image}']")
        expect(page).to have_content(item_1.id)
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_1.current_price)
        expect(page).to have_content(item_1.inventory)
        expect(page).to have_link("Edit Item")
      end

      within "#item-#{item_2.id}" do
        expect(page).to have_css("img[src*='#{item_2.image}']")
        expect(page).to have_content(item_2.id)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_2.current_price)
        expect(page).to have_content(item_2.inventory)
        expect(page).to have_link("Edit Item")
      end
    end

    xit "If no user has ever ordered this item, I see a link to delete the item" do
    end
    xit "If the item is enabled, I see a button or link to disable the item" do
    end
    xit "If the item is disabled, I see a button or link to enable the item" do
    end
  end
end
