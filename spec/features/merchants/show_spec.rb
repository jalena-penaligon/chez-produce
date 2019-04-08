require 'rails_helper'

RSpec.describe "When a merchant visits dashboard show page", type: :feature do
  before :each do
    @user = create(:user)
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    @item_1 = create(:item, user: @merchant_1)
    @item_2 = create(:item, user: @merchant_2)

    @order = create(:order, user: @user)
    @order_item_1 = create(:order_item, order: @order, item: @item_1, order_price: 1, order_quantity: 1)
    @order_item_2 = create(:order_item, order: @order, item: @item_2, order_price: 2, order_quantity: 1)
  end

  it "allows merchant to see their profile data" do

    @merchant_1 = create(:merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    visit dashboard_path

    expect(page).to have_content(@merchant_1.name)
    within('#merchant-profile') do
      expect(page).to have_content(@merchant_1.street_address)
      expect(page).to have_content(@merchant_1.city)
      expect(page).to have_content(@merchant_1.state)
      expect(page).to have_content(@merchant_1.zipcode)
      expect(page).to have_content(@merchant_1.email)
    end
  end

  it "does not allow merchant to edit profile data" do
    expect(page).to_not have_link("Edit Profile")

    # visit '/profile/edit'
    # expect(page.status_code).to eq(404)
  end

  it "I can see pending orders for items I sell" do

    visit dashboard_path


    expect(page).to have_content(@order.id)
    expect(page).to have_content(@order.created_at)
    expect(page).to have_content(@order_item_1.order_quantity)
    expect(page).to have_content("Subtotal: 1")


    click_on "#{@order.id}"
    expect(current_path).to eq(profile_order_path(@merchant_1, @order))

  end

  it "sees a link to view their items" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, user: merchant_1)
    item_2 = create(:item, user: merchant_1)

    merchant_2 = create(:merchant)
    item_3 = create(:item, user: merchant_2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

    visit dashboard_path

    click_on "My Items"
    expect(current_path).to eq('/dashboard/items')
  end
end
