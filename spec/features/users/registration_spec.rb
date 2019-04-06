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

      fill_in :Name, with: name
      fill_in "Street address", with: address
      fill_in :City, with: city
      fill_in :State, with: state
      fill_in :Zipcode, with: zip
      fill_in :Email, with: email
      fill_in :Password, with: password
      fill_in "Password confirmation", with: password

      click_button "Register"

      user = User.last
      expect(page).to have_content(user.name)
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Thanks for registering, you are now logged in!")
    end
  end
  describe 'When I visit the user registration page' do
    describe 'And I do not fill in the form completely' do
      it 'shows a message that required fields are missing' do
        visit root_path
        click_on "Register"

        click_button "Register"

        expect(page).to have_content("Street address can't be blank")
        expect(page).to have_content("City can't be blank")
        expect(page).to have_content("State can't be blank")
        expect(page).to have_content("Zipcode can't be blank")
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password can't be blank")
      end

      it 'will not create a user without a confirmed password' do
        visit root_path
        click_on "Register"

        fill_in :Name, with: "name"
        fill_in "Street address", with: "address"
        fill_in :City, with: "city"
        fill_in :State, with: "state"
        fill_in :Zipcode, with: "zip"
        fill_in :Email, with: "email"
        fill_in :Password, with: "password"

        click_button "Register"

        expect(page).to have_content("Password confirmation doesn't match Password")
      end

      it 'will not allow multiple users with the same email' do
        visit root_path
        click_on "Register"

        fill_in :Name, with: "name"
        fill_in "Street address", with: "address"
        fill_in :City, with: "city"
        fill_in :State, with: "state"
        fill_in :Zipcode, with: "zip"
        fill_in :Email, with: "email@email.com"
        fill_in :Password, with: "password"
        fill_in "Password confirmation", with: 'password'

        click_button "Register"
        click_on "Logout"

        visit root_path
        click_on "Register"
        fill_in :Name, with: "jalena"
        fill_in "Street address", with: "123 address"
        fill_in :City, with: "denver"
        fill_in :State, with: "co"
        fill_in :Zipcode, with: "12345"
        fill_in :Email, with: "email@email.com"
        fill_in :Password, with: "password"
        fill_in "Password confirmation", with: 'password'

        click_button "Register"

        expect(page).to have_content("Email has already been taken")
        expect(page).to have_selector("input[value='jalena']")
        expect(page).to have_selector("input[value='123 address']")
        expect(page).to have_selector("input[value='denver']")
        expect(page).to have_selector("input[value='co']")
        expect(page).to have_selector("input[value='12345']")
        expect(page).to_not have_selector("input[value='email@email.com']")
      end
    end
  end
end
