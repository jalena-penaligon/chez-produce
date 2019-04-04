require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the login path" do
    describe "I see a field to enter my email address and password" do
      describe "when I submit valid information" do
        context "If I am a regular user" do
          it "I am redirected to my profile page, and I see a flash message that I am logged in" do

            user = create(:user)

            visit root_path

            click_link "Login"

            expect(current_path).to eq(login_path)

            fill_in :email, with: user.email
            fill_in :password, with: user.password

            click_button "Login"

            expect(current_path).to eq(profile_path)
            expect(page).to have_content("You're logged in!")
            expect(page).to have_content(user.name)
          end
        end

        context "If I am a merchant user" do
          it "I am redirected to my merchant dashboard page and I see a flash message that I am logged in" do
            merchant = create(:merchant)

            visit root_path

            click_on "Login"

            expect(current_path).to eq(login_path)

            fill_in :email, with: merchant.email
            fill_in :password, with: merchant.password

            click_button "Login"

            expect(current_path).to eq(dashboard_path)
            expect(page).to have_content("You're logged in!")
            expect(page).to have_content(merchant.name)
          end
        end

        context "If I am an admin user" do
          it "I am redirected to the home page of the site and I see a flash message that I am logged in" do
            admin = create(:admin)

            visit root_path

            click_on "Login"

            expect(current_path).to eq(login_path)

            fill_in :email, with: admin.email
            fill_in :password, with: admin.password

            click_button "Login"

            expect(current_path).to eq(root_path)
            expect(page).to have_content("You're logged in!")
          end
        end
      end
    end
  end
end
