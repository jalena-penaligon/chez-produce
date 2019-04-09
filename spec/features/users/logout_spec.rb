require 'rails_helper'

RSpec.describe "As a registered user, merchant, or admin" do
  describe "When I visit the logout path" do
    it "I am redirected to the welcome/home page of the site and see a flash message indicating I've logged out" do

      user = create(:user)

      visit root_path

      click_link "Login"

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button "Login"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You're logged in!")
      expect(page).to have_content(user.name)

      click_link "Logout"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You're logged out!")
      expect(page).to_not have_content("Please try logging out again.")
      expect(page).to have_content("Cart: 0")
    end
  end
end
