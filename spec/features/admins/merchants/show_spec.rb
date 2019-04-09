require 'rails_helper'

RSpec.describe 'As an admin' do
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
