require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit the login path" do
    describe "and I am not logged in" do
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

        describe "when I submit invalid information", type: :feature do
          context "I am redirected to re-enter login information and I see a flash message that I entered incorrect information" do
            it "passwords do not match" do
              user = create(:user)
              visit login_path

              fill_in :email, with: user.email
              fill_in :password, with: "xyz"

              click_button "Login"

              expect(current_path).to eq(login_path)
              expect(page).to have_content("Username or password does not match")
            end
            it "username and password do not exist" do
              visit login_path

              fill_in :email, with: "xyz"
              fill_in :password, with: "xyz"

              click_button "Login"

              expect(current_path).to eq(login_path)
              expect(page).to have_content("Username or password does not match.")
            end
          end
        end
      end
    end

    describe "and I am already logged in" do
      context "as a regular user" do
        it "I am redirected to my profile page and see a flash message that I am already logged it" do
          user = create(:user)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          visit login_path

          expect(current_path).to eq(profile_path)
          expect(page).to have_content("You're already logged in!")
          expect(page).to have_content(user.name)
        end
      end
      context "as a merchant user" do
        it "I am redirected to my dashboard page and see a flash message that I am already logged it" do
          merchant = create(:merchant)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

          visit login_path

          expect(current_path).to eq(dashboard_path)
          expect(page).to have_content("You're already logged in!")
          expect(page).to have_content(merchant.name)
        end
      end
      context "as an admin user" do
        it "I am redirected to the homepage and see a flash message that I am already logged it" do
          admin = create(:admin)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

          visit login_path

          expect(current_path).to eq(root_path)
          expect(page).to have_content("You're already logged in!")
        end
      end
    end
  end
end
