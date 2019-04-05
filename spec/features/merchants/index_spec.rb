require 'rails_helper'

RSpec.describe 'merchant index page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:inactive_merchant)
    @admin = create(:admin)
    @user = create(:user)
  end
  describe "When I visit the merchant index page" do
    it "shows all merchants who are active" do
      visit merchants_path

      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_1.city)
        expect(page).to have_content(@merchant_1.state)
        expect(page).to have_content(@merchant_1.created_at)
      end

      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_2.city)
        expect(page).to have_content(@merchant_2.state)
        expect(page).to have_content(@merchant_2.created_at)
      end

      expect(page).to_not have_content(@merchant_3.name)
    end
  end

  describe "As an admin user" do
    before :each do
      @admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit merchants_path
    end
    describe "I see all the merchants in the system" do
      it "next to each merchant name I see city, state and their name is a link to their dashboard" do #"/admin/merchants/5"

        within "#merchant-#{@merchant_1.id}" do
          expect(page).to have_link(@merchant_1.name)
          expect(page).to have_content(@merchant_1.city)
          expect(page).to have_content(@merchant_1.state)
        end

        within "#merchant-#{@merchant_2.id}" do
          expect(page).to have_link(@merchant_2.name)
          expect(page).to have_content(@merchant_2.city)
          expect(page).to have_content(@merchant_2.state)
        end

        within "#merchant-#{@merchant_3.id}" do
          expect(page).to have_content(@merchant_3.name)
          expect(page).to have_content(@merchant_3.city)
          expect(page).to have_content(@merchant_3.state)

          click_link @merchant_3.name

          expect(current_path).to eq(admin_merchant_path(@merchant_3))
        end
      end

      it "There is a disable button next to any merchant not yet disabled and an enable button to disabled merchants" do

        within "#merchant-#{@merchant_1.id}" do
          expect(page).to have_button("Disable")
        end
        within "#merchant-#{@merchant_2.id}" do
          expect(page).to have_button("Disable")
        end
        within "#merchant-#{@merchant_3.id}" do
          expect(page).to have_button("Enable")
        end
      end
    end
  end
end
