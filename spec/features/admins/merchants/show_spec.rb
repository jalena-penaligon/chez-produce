require 'rails_helper'


RSpec.describe "Admin visits merchant show page: " do
  it "admin sees a link to downgrade merchant's account to become a regular user" do
    merchant_1 = create (:merchant)
    admin = create (:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_merchant_path(merchant_1)

    click_button "Downgrade"
    expect(current_path).to eq(admin_user_path(merchant_1))

    expect(page).to have_content("Merchant is now downgraded to regular user.")
  end

  it "next time user logs in, they are no longer a merchant" do
    merchant = create(:merchant)
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_merchant_path(merchant)

    click_button "Downgrade"
    user = User.find(merchant.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    expect(page.status_code).to eq(404)
  end

  it "all items for sale by downgraded merchant are disabled" do
    merchant = create(:merchant)
    admin = create(:admin)

    item_1 = create(:item, user: merchant)
    item_2 = create(:item, user: merchant)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_merchant_path(merchant)

    click_button "Downgrade"
    user = User.find(merchant.id)
    item_1.reload
    item_2.reload
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit items_path
    expect(item_1.active).to eq(false)
    expect(item_2.active).to eq(false)
   end
  describe 'If I visit a merchant dashboard, but that merchant is a regular user' do
    it 'I am redirected to the appropriate user profile page' do
      user = create(:user, id: 7)
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_path(user.id)

      expect(current_path).to eq(admin_user_path(user.id))
    end
  end

  describe 'If I visit a user profile page, but that user is a merchant' do
    it 'I am redirected to the appropriate merchant dashboard' do
      merchant = create(:merchant, id: 7)
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(merchant.id)

      expect(current_path).to eq(admin_merchant_path(merchant.id))
    end

  end
end
