require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when I visit my items page /dashboard/items" do
    it "I see a link to add a new item, all items and info I have in the system, disable and enable buttons, and delete button if never ordered" do

      merchant = create(:merchant)
      item_1 = create(:item, user_id: merchant.id, active: true)
      item_2 = create(:item, user_id: merchant.id, active: false)
      order_item_1 = create(:order_item, item_id: item_1.id)

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
        expect(page).to have_button("Disable")
      end

      within "#item-#{item_2.id}" do
        expect(page).to have_css("img[src*='#{item_2.image}']")
        expect(page).to have_content(item_2.id)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_2.current_price)
        expect(page).to have_content(item_2.inventory)
        expect(page).to have_link("Edit Item")
        expect(page).to have_button("Enable")
        expect(page).to have_button("Delete")
      end
    end

    it 'when I click on Disable it disables the item, I stay on my items page, there is a flash message, the item is disabled.' do

      merchant = create(:merchant, id: 1)
      item_1 = create(:item, user_id: merchant.id, active: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit '/dashboard/items'

      expect(current_path).to eq(dashboard_items_path)

      within "#item-#{item_1.id}" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_button("Disable")
      end

      within "#item-#{item_1.id}" do
        click_button "Disable"
      end

      item_1 = Item.find(item_1.id)

      expect(item_1.active).to eq(false)
      expect(current_path).to eq('/dashboard/items')
      expect(page).to have_content("The item is now disabled.")

      merchant = User.find(1)

      item_1 = Item.last

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit '/dashboard/items'

      within "#item-#{item_1.id}" do
        expect(page).to have_button("Enable")
      end
    end

    it 'when I click on Enable it enables the item, I stay on my items page, there is a flash message, the item is enabled.' do

      merchant = create(:merchant, id: 1)
      item_1 = create(:item, user_id: merchant.id, active: false)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit '/dashboard/items'

      expect(current_path).to eq(dashboard_items_path)

      within "#item-#{item_1.id}" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_button("Enable")
      end

      within "#item-#{item_1.id}" do
        click_button "Enable"
      end

      item_1 = Item.find(item_1.id)

      expect(item_1.active).to eq(true)
      expect(current_path).to eq('/dashboard/items')
      expect(page).to have_content("The item is now enabled.")

      merchant = User.find(1)

      item_1 = Item.last

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit '/dashboard/items'

      within "#item-#{item_1.id}" do
        expect(page).to have_button("Disable")
      end
    end

    it 'when I click on a delete button for an item, I am returned to the page, I see a flash message, the item is gone' do
      merchant = create(:merchant, id: 25)
      item = create(:item, user_id: merchant.id)

      visit login_path

      fill_in 'Email', with: merchant.email
      fill_in 'Password', with: merchant.password
      click_button "Login"

      visit '/dashboard/items'

      expect(current_path).to eq(dashboard_items_path)

      within "#item-#{item.id}" do
        click_button "Delete"
      end

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("The item has been deleted.")
      expect(page).to_not have_content(item.name)
    end

    it 'if the item has been ordered, there is no delete button and it cannot be deleted' do
      merchant = create(:merchant, id: 2)
      item = create(:item, user_id: merchant.id, id: 1)
      order_item = create(:order_item, item_id: 1)

      visit login_path

      fill_in 'Email', with: merchant.email
      fill_in 'Password', with: merchant.password
      click_button "Login"

      visit '/dashboard/items'

      expect(current_path).to eq(dashboard_items_path)

      within "#item-#{item.id}" do
        expect(page).to_not have_button("Delete")
      end

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content(item.name)
    end
  end
end
