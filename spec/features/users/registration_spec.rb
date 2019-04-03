require 'rails_helper'
RSpec.describe 'As a visitor' do
  describe 'When I click on the register link in the nav bar' do
    it 'i see a form to register' do
      visit root_path    
      click_on "Register"
      name = "hjk"
      address = "hjk"
      city = "hjk"
      state = "hjk"
      zip = "hjk"
      email = "new@g.com"
      password = "hjk"
      confirmation_password = "hjk"

      fill_in :Name, with: name
      fill_in "Street address", with: address
      fill_in :City, with: city
      fill_in :State, with: state
      fill_in :Zipcode, with: zip
      fill_in :Email, with: email
      fill_in :Password, with: password
      fill_in "Confirmation password", with: password

      click_button "Register"

      user = User.last
      expect(page).to have_content(user.name)
      expect(current_path).to eq(profile_path(user))
      expect(page).to have_content("Thanks for registering, you are now logged in!")
    end
  end
end
