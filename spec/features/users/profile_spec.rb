require 'rails_helper'

RSpec.describe 'user profile', type: :feature do
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'As a registered user' do
    describe 'When I visit my own profile page' do
      it 'shows my profile data with a link to edit' do

        visit profile_path(@user)

        expect(page).to have_content(@user.name)
        expect(page).to have_content(@user.email)
        expect(page).to have_content(@user.street_address)
        expect(page).to have_content(@user.city)
        expect(page).to have_content(@user.state)
        expect(page).to have_content(@user.zipcode)
        expect(page).to_not have_content(@user.password)

        click_link("Edit Profile")
        expect(current_path).to eq(edit_profile_path)
      end

      it "can display my orders, if I have any orders" do

        visit profile_path
        
        click_on "My Orders"
        expect(current_path).to eq(profile_orders_path(@user))
      end
    end
  end
end
