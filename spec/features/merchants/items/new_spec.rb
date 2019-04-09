require 'rails_helper'

RSpec.describe 'merchant new item', type: :feature do
  context "As a merchant" do
    describe "when I visit my items page" do
      it "has a link to create a new item" do
        merchant = create(:merchant, id: 1)
        item_1 = create(:item, user: merchant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Add New Item")

        expect(current_path).to eq(dashboard_items_new_path)

        fill_in :Name, with: "Zucchini"
        fill_in :Description, with: "Organic Zucchini Squash, 1.5 lb"
        fill_in :Inventory, with: 17
        fill_in "Current price", with: 2
        fill_in :Image, with: "https://images.unsplash.com/photo-1499125650409-2c437d5cca77?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1789&q=80"

        click_button("Add New Item")

        item_2 = Item.last
        merchant = User.find(1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        expect(current_path).to eq(dashboard_items_path)

        expect(page).to have_content("You successfully added #{item_2.name} to your shop.")

        visit dashboard_items_path
        within "#item-#{item_2.id}" do
          expect(page).to have_content("ID: #{item_2.id}")
          expect(page).to have_content(item_2.name)
          expect(page).to have_content("Price: #{item_2.current_price}")
          expect(page).to have_content("Inventory: #{item_2.inventory}")
          expect(page).to have_css("img[src*='#{item_2.image}']")
          expect(page).to have_button("Disable")
        end
      end

      it "will not add items with missing info" do
        merchant = create(:merchant, id: 1)
        item_1 = create(:item, user: merchant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Add New Item")

        expect(current_path).to eq(dashboard_items_new_path)

        fill_in :Image, with: "https://images.unsplash.com/photo-1499125650409-2c437d5cca77?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1789&q=80"

        click_button("Add New Item")

        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Description can't be blank")
        expect(page).to have_content("Inventory is not a number")
        expect(page).to have_content("Current price is not a number")
      end

      it "will use a default image if no image is added" do
        merchant = create(:merchant, id: 1)
        item_1 = create(:item, user: merchant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Add New Item")

        fill_in :Name, with: "Zucchini"
        fill_in :Description, with: "Organic Zucchini Squash, 1.5 lb"
        fill_in :Inventory, with: 17
        fill_in "Current price", with: 2

        click_button("Add New Item")

        item_2 = Item.last
        merchant = User.find(1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        expect(current_path).to eq(dashboard_items_path)

        expect(page).to have_content("You successfully added #{item_2.name} to your shop.")

        visit dashboard_items_path
        within "#item-#{item_2.id}" do
          expect(page).to have_css("img[src*='#{item_2.image}']")
        end
      end

      it "will not add an item if price is below 0.01" do
        merchant = create(:merchant, id: 1)
        item_1 = create(:item, user: merchant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Add New Item")

        fill_in :Name, with: "Zucchini"
        fill_in :Description, with: "Organic Zucchini Squash, 1.5 lb"
        fill_in :Inventory, with: 17
        fill_in "Current price", with: 0

        click_button("Add New Item")
        expect(page).to have_content("Current price must be greater than 0")
      end

      it "will not add an item if inventory is less than 1" do
        merchant = create(:merchant, id: 1)
        item_1 = create(:item, user: merchant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Add New Item")

        fill_in :Name, with: "Zucchini"
        fill_in :Description, with: "Organic Zucchini Squash, 1.5 lb"
        fill_in :Inventory, with: -1
        fill_in "Current price", with: 0.99

        click_button("Add New Item")
        expect(page).to have_content("Inventory must be greater than -1")
      end
    end
  end
end
