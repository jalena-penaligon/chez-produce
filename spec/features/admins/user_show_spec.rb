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
  end
end


# As an admin user
# When I visit a user's profile page ("/admin/users/5")
# I see the same information the user would see themselves
# I do not see a link to edit their profile
