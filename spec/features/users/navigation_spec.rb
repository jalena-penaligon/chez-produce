require 'rails_helper'

RSpec.describe "navigation" do
  before(:each) do
  	@user = create(:user)
  	allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

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
  describe 'As a registered user' do
    xit 'I see the same links as a visitor' do
      visit root_path

      click_on "Home"
      expect(current_path).to eq(root_path)

      click_on "Shop"
      expect(current_path).to eq(items_path)

      click_on "Merchants"
      expect(current_path).to eq(merchants_path)

      click_on "Cart"
      expect(current_path).to eq(cart_path)

      click_on "Logout"
      expect(current_path).to eq(logout_path)

      click_on "Profile"
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Logged in as #{user.name}")
    end
  end
end
