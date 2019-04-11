require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :orders }
  end

  describe 'instance methods' do
    it 'can calc total_inventory' do
        user = create(:user)
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        item_1 = create(:item, user: merchant_1, name: "Zucchini", inventory: 4)
        item_2 = create(:item, user: merchant_1, name: "Zucchini", inventory: 4)
        order = create(:order, user: user)
        create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1)
        order = create(:packaged_order, user: user)
        oi_1 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 1, order_quantity: 1, created_at: 3.5.days.ago, updated_at: 1.days.ago)
        oi_2 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 1, order_quantity: 3, created_at: 3.5.days.ago, updated_at: 1.days.ago)
      actual = merchant_1.total_inventory
      expect(actual).to eq(8)
    end
  end

  describe 'class methods' do
    it '.all_users returns all users' do
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:inactive_user)
      admin = create(:admin)
      merchant = create(:merchant)

      expect(User.all_users).to eq([user_1, user_2, user_3])
    end

    it '.active_merchants returns active merchants' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:inactive_merchant)

      expect(User.active_merchants).to eq([merchant_1, merchant_2])
    end

    it '.all_merchants returns all merchants' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:inactive_merchant)

      expect(User.all_merchants).to eq([merchant_1, merchant_2, merchant_3])
    end

    it '.top_merchants_by_revenue returns merchants with most revenue' do
      user = create(:user)
      order = create(:shipped_order, user: user)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)
      item_1 = create(:item, user: merchant_1)
      item_2 = create(:item, user: merchant_2)
      item_3 = create(:item, user: merchant_3)
      item_4 = create(:item, user: merchant_4)
      order_item_1 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 3.0, order_quantity: 6, created_at: 5.days.ago, updated_at: 10.minutes.ago)
      order_item_2 = create(:fulfilled_order_item, order: order, item: item_2, order_price: 4.5, order_quantity: 2, created_at: 5.days.ago, updated_at: 10.hours.ago)
      order_item_3 = create(:fulfilled_order_item, order: order, item: item_3, order_price: 6.0, order_quantity: 1, created_at: 5.days.ago, updated_at: 3.hours.ago)
      order_item_4 = create(:fulfilled_order_item, order: order, item: item_4, order_price: 10.0, order_quantity: 5, created_at: 5.days.ago, updated_at: 5.hours.ago)
      order_item_5 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 3.0, order_quantity: 2, created_at: 5.days.ago, updated_at: 5.hours.ago)
      order_item_6 = create(:fulfilled_order_item, order: order, item: item_2, order_price: 4.5, order_quantity: 1, created_at: 5.days.ago, updated_at: 5.hours.ago)

      expect(User.top_merchants_by_revenue).to eq([merchant_4, merchant_1, merchant_2])
    end

    it '.merchants_by_fulfillment returns merchants with the fastest fulfillment times' do
      user = create(:user)
      order = create(:shipped_order, user: user)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)
      item_1 = create(:item, user: merchant_1)
      item_2 = create(:item, user: merchant_2)
      item_3 = create(:item, user: merchant_3)
      item_4 = create(:item, user: merchant_4)
      order_item_1 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 3.0, order_quantity: 6, created_at: 6.days.ago, updated_at: 3.days.ago)
      order_item_2 = create(:fulfilled_order_item, order: order, item: item_2, order_price: 4.5, order_quantity: 2, created_at: 6.days.ago, updated_at: 1.days.ago)
      order_item_3 = create(:fulfilled_order_item, order: order, item: item_3, order_price: 6.0, order_quantity: 1, created_at: 6.days.ago, updated_at: 4.days.ago)
      order_item_4 = create(:fulfilled_order_item, order: order, item: item_4, order_price: 10.0, order_quantity: 5, created_at: 6.days.ago, updated_at: 5.days.ago)
      order_item_5 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 3.0, order_quantity: 2, created_at: 6.days.ago, updated_at: 1.days.ago)
      order_item_6 = create(:fulfilled_order_item, order: order, item: item_2, order_price: 4.5, order_quantity: 1, created_at: 6.days.ago, updated_at: 2.days.ago)

      expect(User.merchants_by_fulfillment("ASC")).to eq([merchant_4, merchant_3, merchant_1])
    end

    it '.merchants_by_fulfillment returns merchants with the slowest fulfillment times' do
      user = create(:user)
      order = create(:shipped_order, user: user)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)
      item_1 = create(:item, user: merchant_1)
      item_2 = create(:item, user: merchant_2)
      item_3 = create(:item, user: merchant_3)
      item_4 = create(:item, user: merchant_4)
      order_item_1 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 3.0, order_quantity: 6, created_at: 6.days.ago, updated_at: 3.days.ago)
      order_item_2 = create(:fulfilled_order_item, order: order, item: item_2, order_price: 4.5, order_quantity: 2, created_at: 6.days.ago, updated_at: 1.days.ago)
      order_item_3 = create(:fulfilled_order_item, order: order, item: item_3, order_price: 6.0, order_quantity: 1, created_at: 6.days.ago, updated_at: 4.days.ago)
      order_item_4 = create(:fulfilled_order_item, order: order, item: item_4, order_price: 10.0, order_quantity: 5, created_at: 6.days.ago, updated_at: 5.days.ago)
      order_item_5 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 3.0, order_quantity: 2, created_at: 6.days.ago, updated_at: 1.days.ago)
      order_item_6 = create(:fulfilled_order_item, order: order, item: item_2, order_price: 4.5, order_quantity: 1, created_at: 6.days.ago, updated_at: 2.days.ago)

      expect(User.merchants_by_fulfillment("DESC")).to eq([merchant_2, merchant_1, merchant_3])
    end

    it '.top_states returns top states ordered from' do
      user_1 = User.create(name: "name", state: "CO", city: "Denver", email: "emai@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
      user_2 = User.create(name: "name", state: "WY", city: "Denver", email: "ema@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
      user_3 = User.create(name: "name", state: "CT", city: "Denver", email: "em@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
      user_4 = User.create(name: "name", state: "MN", city: "Denver", email: "e@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
      order_1 = create(:shipped_order, user: user_3)
      order_2 = create(:shipped_order, user: user_3)
      order_3 = create(:shipped_order, user: user_3)
      order_3 = create(:shipped_order, user: user_3)
      order_4 = create(:shipped_order, user: user_1)
      order_5 = create(:shipped_order, user: user_1)
      order_6 = create(:shipped_order, user: user_1)
      order_7 = create(:shipped_order, user: user_2)
      order_8 = create(:shipped_order, user: user_2)

      expect(User.top_states[0].state).to eq("CT")
      expect(User.top_states[1].state).to eq("CO")
      expect(User.top_states[2].state).to eq("WY")
    end

    it '.top_cities returns top cities ordered from' do
      user_1 = User.create(name: "name", state: "CO", city: "Denver", email: "emai@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
      user_2 = User.create(name: "name", state: "WY", city: "Cheyenne", email: "ema@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
      user_3 = User.create(name: "name", state: "CT", city: "Hartford", email: "em@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
      user_4 = User.create(name: "name", state: "MN", city: "Minneapolis", email: "e@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
      user_5 = User.create(name: "name", state: "CO", city: "Denver", email: "e@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
      order_1 = create(:shipped_order, user: user_3)
      order_2 = create(:shipped_order, user: user_3)
      order_3 = create(:shipped_order, user: user_3)
      order_3 = create(:shipped_order, user: user_3)
      order_4 = create(:shipped_order, user: user_1)
      order_5 = create(:shipped_order, user: user_1)
      order_6 = create(:shipped_order, user: user_1)
      order_7 = create(:shipped_order, user: user_2)
      order_8 = create(:shipped_order, user: user_2)
      order_9 = create(:shipped_order, user: user_5)

      expect(User.top_cities[0].city).to eq("Hartford")
      expect(User.top_cities[1].city).to eq("Denver")
      expect(User.top_cities[2].city).to eq("Cheyenne")
    end
  end
end
