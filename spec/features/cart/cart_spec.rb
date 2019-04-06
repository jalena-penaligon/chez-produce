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
        expect(page).to have_content("#{item_1.name.capitalize} has been added to your cart!")
        expect(page).to have_content("Cart: 1")

        item_2 = create(:item)

        visit item_path(item_2)

        click_link "Add to Cart"

        expect(current_path).to eq(items_path)
        expect(page).to have_content("#{item_2.name.capitalize} has been added to your cart!")
        expect(page).to have_content("Cart: 2")
      end
    end
  end
end
