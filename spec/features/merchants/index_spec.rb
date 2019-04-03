require 'rails_helper'

RSpec.describe 'merchant index page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:inactive_merchant)
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
end
