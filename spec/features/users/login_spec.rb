require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the login path" do
    describe "I see a field to enter my email address and password" do
      describe "when I submit valid information" do
        context "If I am a regular user, I am redirected to my profile page, and I see a flash message that I am logged in" do
          regular = User.create(email: "abc@ymail.com",
                                    password: "pass",
                                    role:0)

          visit root_path

          click_link "Login"

          expect(current_path).to eq(login_path)

          fill_in :email, with: "abc@ymail.com"
          fill_in :password, with: "pass"

          expect(current_path).to eq(profile_path(regular))
          expect(page).to have_content("You're logged in!")
        end
        # context "If I am a merchant user, I am redirected to my merchant dashboard page and I see a flash message that I am logged in" do
        # merchant = User.create(email: "abc@ymail.com", password: "pass", role:1)
        # end
        # context "If I am an admin user, I am redirected to the home page of the site and I see a flash message that I am logged in" do
        # admin = User.create(email: "abc@ymail.com", password: "pass", role:2)
        # end
      end
    end
  end
end
