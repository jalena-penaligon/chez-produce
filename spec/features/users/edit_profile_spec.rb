require  'rails_helper'

RSpec.describe "As a registered user, they click on edit" do
  it "they see their profile data populate" do
    user_1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit edit_profile_path

    expect(find_field('Name').value).to eq(user_1.name)
    expect(find_field('Street address').value).to eq(user_1.street_address)
    expect(find_field('City').value).to eq(user_1.city)
    expect(find_field('State').value).to eq(user_1.state)
    expect(find_field('Zipcode').value).to eq(user_1.zipcode)
    expect(find_field('Email').value).to eq(user_1.email)
  end

  it "they can edit the data in the form and see the updated information" do
    user_1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit edit_profile_path

    fill_in "user[name]", with: "Smitha"

    click_button "Update Profile"
    expect(current_path).to eq(profile_path)

    expect(page).to have_content("Your profile was updated.")

    expect(page).to have_content("Smitha")
    expect(page).to have_content(user_1.city)
  end

  it "they can change email to a unique email address" do
    user_1 = create(:user)
    user_2 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit edit_profile_path

    fill_in "user[email]", with: "user_2@gmail.com"

    click_button "Update Profile"
    expect(current_path).to eq(user_path(user_1))
    expect(page).to have_content("Email has already been taken")
  end
end
