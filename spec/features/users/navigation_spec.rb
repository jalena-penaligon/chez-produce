require 'rails_helper'

RSpec.describe "navigation" do

  before(:each) do
  	@user = create(:user)
  	allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  
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
    end
  end
  
  describe 'As a registered user' do
    it 'I see all the links visible only to registered user' do
      user = User.create!(name: 'j', email: "j@gmail.com", password:"password", role:0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit login_path

      fill_in :Email, with: user.email
      fill_in :Password, with: user.password

      click_on "Login"

      expect(page).to_not have_content("Register")
      expect(page).to_not have_content("Login")
      
      click_on "Logout"
      expect(current_path).to eq(root_path)

      click_on "Profile"
      expect(current_path).to eq(profile_path(user))

      expect(page).to have_content("Logged in as #{user.name}")
    end
  end
end
