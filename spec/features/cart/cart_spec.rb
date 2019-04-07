require 'rails_helper'

RSpec.describe 'cart page', type: :feature do
  context 'as a visitor or registered user' do
    describe 'when I visit my cart /cart and there are no items' do
      it 'shows a message that my cart is empty' do
        visit cart_path

        expect(page).to have_content("Your cart is empty.")
        expect(page).to_not have_link("Clear Cart")
      end
    end

    describe "As a visitor or registered user" do
      it "can add items to cart" do
        item_1 = create(:item)

        visit item_path(item_1)

        click_link "Add to Cart"

        expect(current_path).to eq(items_path)
        expect(page).to have_content("#{item_1.name} has been added to your cart!")
        expect(page).to have_content("Cart: 1")

        item_2 = create(:item)

        visit item_path(item_2)

        click_link "Add to Cart"

        expect(current_path).to eq(items_path)
        expect(page).to have_content("#{item_2.name} has been added to your cart!")
        expect(page).to have_content("Cart: 2")
      end
    end
    describe 'as a visitor or user' do
      describe 'when I have items in my cart' do
        it 'displays info about cart contents' do

          item_1 = create(:item, id: 1, current_price: 3.0)
          visit item_path(item_1)
          click_link "Add to Cart"

          visit item_path(item_1)
          click_link "Add to Cart"

          item_2 = create(:item, id: 2, current_price: 4.5)
          visit item_path(item_2)
          click_link "Add to Cart"

          visit cart_path

          within "#item-#{item_1.id}" do
            expect(page).to have_content(item_1.name)
            expect(page).to have_content(item_1.user.name)
            expect(page).to have_content(item_1.current_price)
            expect(page).to have_content("Quantity: 2")
            expect(page).to have_content("Subtotal: $6.00")
            expect(page).to have_css("img[src*='#{item_1.image}']")
          end

          within "#item-#{item_2.id}" do
            expect(page).to have_content(item_2.name)
            expect(page).to have_content(item_2.user.name)
            expect(page).to have_content(item_2.current_price)
            expect(page).to have_content("Quantity: 1")
            expect(page).to have_content("Subtotal: $4.50")
            expect(page).to have_css("img[src*='#{item_2.image}']")
          end

          expect(page).to have_content("Total: $10.50")
          expect(page).to have_link("Clear Cart")

        end
      end
    end
  end


#   As a visitor or registered user
# When I have added items to my cart
# And I visit my cart ("/cart")
# I see all items I've added to my cart
# And I see a link to empty my cart
# Each item in my cart shows the following information:
# - the name of the item
# - a very small thumbnail image of the item
# - the merchant I'm buying this item from
# - the price of the item
# - my desired quantity of the item
# - a subtotal (price multiplied by quantity)
end
