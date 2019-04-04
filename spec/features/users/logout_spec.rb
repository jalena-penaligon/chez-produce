require 'rails_helper'

RSpec.describe "As a registered user, merchant, or admin" do
  describe "When I visit the logout path" do
    it "I am redirected to the welcome/home page of the site and see a flash message indicating I've logged out" do

      visit logout_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You're logged out!")
    end
    xit "Any items I had in my shopping cart are deleted" do
      visit logout_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Cart: 0")
    end
  end
end
