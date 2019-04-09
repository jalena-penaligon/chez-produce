require 'rails_helper'

RSpec.describe 'admin views a user show page', type: :feature do
  context "as an admin" do
    it 'shows all profile info without edit link' do
      user = create(:user)
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit root_path
      click_link "Users"
      click_link "#{user.name}"

      expect(current_path).to eq(admin_user_path(user))

      expect(page).to have_content(user.name)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.street_address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zipcode)
    end

    it "can make a User a merchant" do
      user = create(:user)
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user)

      click_button "Upgrade"
      expect(current_path).to eq(admin_merchant_path(user))

      expect(page).to have_content("User has been upgraded.")
    end

    it "user can now login as merchant" do
      user = create(:user)
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user)

      click_button "Upgrade"
      merchant = User.find(user.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit dashboard_path
      expect(page.status_code).to eq(200)
    end
  end
end
