require 'rails_helper'

RSpec.describe 'merchant edit items', type: :feature do
  context "As a merchant" do
    describe "when I visit my items page" do
      it "has a link to edit an existing item" do
        merchant = create(:merchant, id: 1)
        item = merchant.items.create(id: 1, name: "Apple", image: "https://images.unsplash.com/photo-1478004521390-655bd10c9f43?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80", description: "Gala Apple, One Medium. Organic, natural, can be stored in refrigerators.", inventory: 15, current_price: 0.50, active: true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Edit Item")
        expect(current_path).to eq(dashboard_item_edit_path(item))
        expect(page).to have_selector("input[value='#{item.name}']")
        expect(page).to have_selector("input[value='#{item.description}']")
        expect(page).to have_selector("input[value='#{item.current_price}']")
        expect(page).to have_selector("input[value='#{item.inventory}']")
        expect(page).to have_selector("input[value='#{item.image}']")
        fill_in :Description, with: "Gala Apple. One large."
        fill_in :Inventory, with: 45

        click_button("Update Item")

        expect(current_path).to eq(dashboard_items_path)
        expect(page).to have_content("Your item has been updated.")

        merchant = User.find(1)
        item = Item.find(1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path
        expect(page).to have_content("Inventory: 45")
        expect(page).to have_button("Disable")

        visit item_path(item)
        expect(page).to have_content("Gala Apple. One large.")
      end

      it "will not let you leave name or description blank" do
        merchant = create(:merchant, id: 1)
        item = merchant.items.create(id: 1, name: "Apple", image: "https://images.unsplash.com/photo-1478004521390-655bd10c9f43?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80", description: "Gala Apple, One Medium. Organic, natural, can be stored in refrigerators.", inventory: 15, current_price: 0.50, active: true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Edit Item")

        fill_in :Description, with: ""
        fill_in :Name, with: ""

        click_button("Update Item")

        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Description can't be blank")
      end

      it "will not let you drop price below 0.01 or inventory below 0" do
        merchant = create(:merchant, id: 1)
        item = merchant.items.create(id: 1, name: "Apple", image: "https://images.unsplash.com/photo-1478004521390-655bd10c9f43?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80", description: "Gala Apple, One Medium. Organic, natural, can be stored in refrigerators.", inventory: 15, current_price: 0.50, active: true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Edit Item")

        fill_in :Inventory, with: -5
        fill_in "Current price", with: 0

        click_button("Update Item")

        expect(page).to have_content("Inventory must be greater than -1")
        expect(page).to have_content("Current price must be greater than 0")
      end

      it "will use the default image if image is removed" do
        merchant = create(:merchant, id: 1)
        item = merchant.items.create(id: 1, name: "Apple", image: "https://images.unsplash.com/photo-1478004521390-655bd10c9f43?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80", description: "Gala Apple, One Medium. Organic, natural, can be stored in refrigerators.", inventory: 15, current_price: 0.50, active: true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Edit Item")

        fill_in :Image, with: ""

        click_button("Update Item")

        merchant = User.find(1)
        item = Item.find(1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        within "#item-#{item.id}" do
          expect(page).to have_css("img[src*='http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg']")
        end
      end

      it "will repopulate my form data if field(s) are missing" do
        merchant = create(:merchant, id: 1)
        item = merchant.items.create(id: 1, name: "Apple", image: "https://images.unsplash.com/photo-1478004521390-655bd10c9f43?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80", description: "Gala Apple, One Medium. Organic, natural, can be stored in refrigerators.", inventory: 15, current_price: 0.50, active: true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path

        click_link("Edit Item")

        fill_in :Name, with: ""
        expect(page).to have_selector("input[value='#{item.description}']")
        expect(page).to have_selector("input[value='#{item.current_price}']")
        expect(page).to have_selector("input[value='#{item.inventory}']")
        expect(page).to have_selector("input[value='#{item.image}']")

        click_button("Update Item")

        expect(page).to have_content("Name can't be blank")

      end
    end
  end
end
