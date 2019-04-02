require 'rails_helper'

RSpec.describe "navigation" do
  describe "visitor navigation" do
    it "should have links" do

      visit root_path

      click_on "Home"

      expect(current_path).to eq(root_path)

      click_on "Shop"

      expect(current_path).to eq(items_path)

      click_on "Merchants"

      expect(current_path).to eq(merchants_path)

      click_on "Cart"

      expect(current_path).to eq(cart_path)

      click_on "Login"

      expect(current_path).to eq(login_path)

      click_on "Register"

      expect(current_path).to eq(register_path)

    end
  end
end
