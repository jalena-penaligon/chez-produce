require 'rails_helper'
# include Range
RSpec.describe 'As any kind of user on the system' do
  before :each do
    @sam = User.create!(name:"samFields", role: 2, password: "salad", email:"sam@g.com", city: "Denver", state: "CO", zipcode: "80209", street_address: "23 lilly ave")
    @justin = User.create!(name:"justinFields", role: 2, password: "salad", email:"justinfields@g.com", city: "Denver", state: "CO", zipcode: "80209", street_address: "24 lilly ave")
    @item_1 = @sam.items.create(name:"apples", inventory: 10, current_price: 1.50, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg", description: "some stuff")
    @item_2 = @justin.items.create(name:"bananas", inventory: 5, current_price: 2.00, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg", description: "some stuff")
    @item_3 = @sam.items.create(name:"cantaloupe", inventory: 5, current_price: 1.50, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg", description: "some stuff")
    @item_4 = @sam.items.create(name:"kale", inventory: 5, current_price: 1.50, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg", description: "some stuff")
    @item_5 = @sam.items.create(name:"rutabaga", inventory: 5, current_price: 1.50, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg", description: "some stuff")
    @item_6 = @sam.items.create(name:"zucchini", inventory: 5, current_price: 1.50, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg", description: "some stuff")
    @user = create(:user)
    @order = create(:shipped_order, user: @user)
    create(:fulfilled_order_item, order: @order, item: @item_1, order_price: 1, order_quantity: 1, created_at: 3.days.ago, updated_at: 59.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_2, order_price: 2, order_quantity: 2, created_at: 4.hour.ago, updated_at: 59.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_3, order_price: 1, order_quantity: 3, created_at: 3.days.ago, updated_at: 59.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_4, order_price: 2, order_quantity: 4, created_at: 4.hour.ago, updated_at: 59.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_5, order_price: 2, order_quantity: 5, created_at: 4.hour.ago, updated_at: 59.minutes.ago)
    create(:fulfilled_order_item, order: @order, item: @item_6, order_price: 2, order_quantity: 6, created_at: 4.hour.ago, updated_at: 59.minutes.ago)
    end
  describe "I can visit the items catalog (items)" do
    it 'I see all items in the system except disabled items' do
      visit items_path

      expect(page).to have_content(@sam.name)
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.inventory)
      expect(page).to have_content(@item_1.current_price)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_3.inventory)
      expect(page).to have_content(@item_3.current_price)
      expect(page).to have_content(@justin.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.inventory)
      expect(page).to have_content(@item_2.current_price)
      expect(page).to have_css("img[src*='#{@item_1.image}']")
      expect(page).to have_css("img[src*='#{@item_2.image}']")
      expect(page).to have_css("img[src*='#{@item_3.image}']")
    end
    it 'i see an area with statistics' do
      visit items_path
      
      within ".most-popular" do
        expect(page).to have_content("Most Popular Items: zucchini: 6 rutabaga: 5 kale: 4 cantaloupe: 3 bananas: 2")
      end
      within ".least-popular" do
        expect(page).to have_content("Least Popular Items: apples: 1 bananas: 2 cantaloupe: 3 kale: 4 rutabaga: 5")
      end
      # - the top 5 most popular items by quantity purchased, plus the quantity bought
      # - the bottom 5 least popular items, plus the quantity bought
      #
      # "Popularity" is determined by total quantity of that item fulfilled
    end
  end
end
