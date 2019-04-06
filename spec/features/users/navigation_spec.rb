require 'rails_helper'

RSpec.describe "navigation" do
  describe "all users navigation" do
    it "should show all the common links visible to all users" do

      visit root_path

      click_on "Home"
      expect(current_path).to eq(root_path)

      click_on "Shop"
      expect(current_path).to eq(items_path)

      click_on "Merchants"
      expect(current_path).to eq(merchants_path)

      click_on "Cart"
      expect(current_path).to eq(cart_path)
    end

  end

  describe "visitor navigation" do
    it "should have links visible only to visitor" do

      visit root_path

      click_on "Login"
      expect(current_path).to eq(login_path)

      click_on "Register"
      expect(current_path).to eq(register_path)

      expect(page).to_not have_content("Logout")
    end
    it 'can restrict access for visitors' do
      visit profile_path
      expect(page.status_code).to eq(404)

      visit dashboard_path
      expect(page.status_code).to eq(404)

      visit admin_dashboard_path
      expect(page.status_code).to eq(404)
    end
  end

  describe 'As a registered user' do
    it 'I see all the links visible only to registered user' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      expect(page).to_not have_content("Register")
      expect(page).to_not have_content("Login")

      within('#user-nav') do
        click_on "Logout"
        expect(current_path).to eq(root_path)

        click_on "Profile"
        expect(current_path).to eq(profile_path)

        expect(page).to have_content("Logged in as #{user.name}")
      end
    end
    it 'can restrict access for registered user' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      expect(page.status_code).to eq(404)

      visit admin_users_path
      expect(page.status_code).to eq(404)
    end

  end

  describe "As a merchant user" do
    it "I see all the links visible only to merchant user" do
      merchant_1 = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      visit root_path

      expect(page).to_not have_content("Register")
      expect(page).to_not have_content("Login")

      within('#merchant-nav') do
        click_on "Logout"
        expect(current_path).to eq(root_path)

        click_on "Dashboard"
        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content("Logged in as #{merchant_1.name}")
      end
    end
    it 'can restrict access for merchant' do
      merchant_1 = create(:merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      visit profile_path
      expect(page.status_code).to eq(404)

      visit admin_users_path
      expect(page.status_code).to eq(404)

      visit cart_path
      expect(page.status_code).to eq(404)
    end
  end

  describe "As an admin user" do
    it "I see only the links visible to admin" do
      admin = create(:admin)
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit root_path

      expect(page).to_not have_content("Register")
      expect(page).to_not have_content("Login")

      within('#admin-nav') do

        expect(page).to have_content("Logged in as #{admin.name}")

        # click_on "Dashboard"
        # expect(current_path).to eq(admin_dashboard_path)

        visit root_path

        click_on "Logout"
        expect(current_path).to eq(root_path)
      end
    end
    it 'can restrict access for admin' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit profile_path
      expect(page.status_code).to eq(404)

      visit dashboard_path
      expect(page.status_code).to eq(404)

      visit cart_path
      expect(page.status_code).to eq(404)
    end
  end
end
