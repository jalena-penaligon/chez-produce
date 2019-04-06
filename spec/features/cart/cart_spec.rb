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
  end
end
