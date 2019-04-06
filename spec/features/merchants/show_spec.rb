require 'rails_helper'

RSpec.describe "When a merchant visits dashboard show page", type: :feature do
  it "allows merchant to see their profile data" do
    merchant_1 = create(:merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

    visit dashboard_path

    expect(page).to have_content(merchant_1.name)
    within('#merchant-profile') do
      expect(page).to have_content(merchant_1.street_address)
      expect(page).to have_content(merchant_1.city)
      expect(page).to have_content(merchant_1.state)
      expect(page).to have_content(merchant_1.zipcode)
      expect(page).to have_content(merchant_1.email)
    end
  end

  it "does not allow merchant to edit profile data" do
    expect(page).to_not have_link("Edit Profile")

    # visit '/profile/edit'
    # expect(page.status_code).to eq(404)
  end
end
