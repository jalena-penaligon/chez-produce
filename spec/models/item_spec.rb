require 'rails_helper'

RSpec.describe Item, type: :model do
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

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :order_items }
    it { should have_many(:orders).through(:order_items) }
    it { should belong_to :user }
  end

  describe 'class methods' do
    it 'can calc most popular items' do
      actual = Item.items_sold(5,'desc')
      expect(actual).to eq([@item_6,@item_5,@item_4,@item_3,@item_2])
    end
    it 'can calc least popular items' do
      actual = Item.items_sold(5,'asc')
      expect(actual).to eq([@item_1,@item_2,@item_3,@item_4,@item_5])
    end
  end

  describe 'instance methods' do
    it '#not_ordered?' do
      merchant = create(:merchant)
      item_1 = create(:item, user_id: merchant.id, active: true)
      item_2 = create(:item, user_id: merchant.id, active: false)
      order_item_1 = create(:order_item, item_id: item_1.id)

      expect(item_1.not_ordered?).to eq(false)
      expect(item_2.not_ordered?).to eq(true)
    end
  end
end
