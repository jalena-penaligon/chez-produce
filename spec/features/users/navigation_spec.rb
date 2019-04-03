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
  describe 'As a registered user' do
    it 'I see the same links as a visitor except, Register and Login.  I also see link for Profile and Logout' do
      user = User.create!(name: 'j', email: "j@gmail.com", password:"password", role:0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit login_path

      fill_in :Email, with: user.email
      fill_in :Password, with: user.password

      click_on "Login"

      expect(page).to_not have_content("Register")
      expect(page).to_not have_content("Login")
      
      click_on "Home"
      expect(current_path).to eq(root_path)

      click_on "Shop"
      expect(current_path).to eq(items_path)

      click_on "Merchants"
      expect(current_path).to eq(merchants_path)

      click_on "Cart"
      expect(current_path).to eq(cart_path)

      click_on "Logout"
      expect(current_path).to eq(root_path)

      click_on "Profile"
      expect(current_path).to eq(profile_path(user))

      expect(page).to have_content("Logged in as #{user.name}")
    end
  end
end
