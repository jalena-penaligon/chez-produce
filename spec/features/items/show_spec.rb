require 'rails_helper'

RSpec.describe 'When I visit an items show page from the items catalog' do
  before :each do
    @sam = User.create!(name:"samFields", role: 2, password: "salad", email:"sam@g.com", city: "Denver", state: "CO", zipcode: "80209", street_address: "23 lilly ave")
    @item_1 = @sam.items.create(name:"apples", inventory: 10, current_price: 1.50, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg", description: "some stuff")
    @user = create(:user)
    @admin = create(:admin)
    @order = create(:shipped_order, user: @user)
    create(:fulfilled_order_item, order: @order, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.hour.ago, updated_at: 2.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_1, order_price: 2, order_quantity: 2, created_at: 4.hour.ago, updated_at: 2.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_1, order_price: 1, order_quantity: 3, created_at: 4.hour.ago, updated_at: 2.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_1, order_price: 2, order_quantity: 4, created_at: 4.hour.ago, updated_at: 2.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_1, order_price: 2, order_quantity: 5, created_at: 4.hour.ago, updated_at: 2.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_1, order_price: 2, order_quantity: 6, created_at: 4.hour.ago, updated_at: 2.minutes.ago)
  end
  context 'As any kind of user on the system' do
    it 'I see all information for this item' do
      visit item_path(@item_1)
      save_and_open_page
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.image)
      expect(page).to have_content(@sam.name)
      expect(page).to have_content(@item_1.inventory)
      expect(page).to have_content(@item_1.current_price)
      expect(page).to have_content(@item_1.average_item_fulfillment)
    end
  end
  context 'If I am a visitor or regular user' do
    it 'I also see a link to add this item to my cart' do
      visit item_path(@item_1)
    end
  end
end
