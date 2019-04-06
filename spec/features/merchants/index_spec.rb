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
        expect(page).to have_content(@merchant_1.created_at.to_s(:long))
      end

      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_2.city)
        expect(page).to have_content(@merchant_2.state)
        expect(page).to have_content(@merchant_2.created_at.to_s(:long))
      end

      expect(page).to_not have_content(@merchant_3.name)
    end

    describe 'the index page displays merchant statistics' do
      it 'top 3 merchants by price, quantity, and revenue' do
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

        visit merchants_path

        within '#top-by-revenue' do
          expect(page).to have_content(merchant_4.name)
          expect(page).to have_content("Total Revenue: 50")
          expect(page).to have_content(merchant_1.name)
          expect(page).to have_content("Total Revenue: 24")
          expect(page).to have_content(merchant_2.name)
          expect(page).to have_content("Total Revenue: 13.5")
          expect(page).to_not have_content(merchant_3.name)
        end

      end

      it 'top 3 merchants who fulfilled items fastest, plus their times' do
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

        visit merchants_path

        within '#top-by-fulfillment' do
          expect(page).to have_content(merchant_4.name)
          expect(page).to have_content("Fulfillment Time: 1 day")
          expect(page).to have_content(merchant_3.name)
          expect(page).to have_content("Fulfillment Time: 2 days")
          expect(page).to have_content(merchant_1.name)
          expect(page).to have_content("Fulfillment Time: 4 days")
          expect(page).to_not have_content(merchant_2.name)
        end

        within '#bottom-by-fulfillment' do
          expect(page).to have_content(merchant_2.name)
          expect(page).to have_content("Fulfillment Time: 4 days")
          expect(page).to have_content(merchant_1.name)
          expect(page).to have_content("Fulfillment Time: 4 days")
          expect(page).to have_content(merchant_3.name)
          expect(page).to have_content("Fulfillment Time: 2 days")
          expect(page).to_not have_content(merchant_4.name)
        end
      end

      it 'top 3 states where any orders were shipped, and count of orders' do
        user_1 = User.create(name: "name", state: "CO", city: "Denver", email: "emai@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
        user_2 = User.create(name: "name", state: "WY", city: "Denver", email: "ema@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
        user_3 = User.create(name: "name", state: "CT", city: "Denver", email: "em@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
        user_4 = User.create(name: "name", state: "MN", city: "Denver", email: "e@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
        order_1 = create(:shipped_order, user: user_1)
        order_2 = create(:shipped_order, user: user_1)
        order_3 = create(:shipped_order, user: user_1)
        order_4 = create(:shipped_order, user: user_2)
        order_5 = create(:shipped_order, user: user_2)
        order_6 = create(:shipped_order, user: user_3)

        visit merchants_path

        within '#top-states' do
          expect(page).to have_content("CO")
          expect(page).to have_content("WY")
          expect(page).to have_content("CT")
          expect(page).to_not have_content("MN")
        end
      end

      it 'top 3 cities where any orders were shipped, and the count of orders' do
        user_1 = User.create(name: "name", state: "CO", city: "Denver", email: "emai@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
        user_2 = User.create(name: "name", state: "WY", city: "Cheyenne", email: "ema@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
        user_3 = User.create(name: "name", state: "CT", city: "Hartford", email: "em@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
        user_4 = User.create(name: "name", state: "MN", city: "Minneapolis", email: "e@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
        user_5 = User.create(name: "name", state: "WY", city: "Denver", email: "e@email.com", zipcode: "12345", password: "pass", street_address: "123 street")
        order_1 = create(:shipped_order, user: user_1)
        order_2 = create(:shipped_order, user: user_1)
        order_3 = create(:shipped_order, user: user_1)
        order_4 = create(:shipped_order, user: user_2)
        order_5 = create(:shipped_order, user: user_2)
        order_6 = create(:shipped_order, user: user_3)
        order_7 = create(:shipped_order, user: user_5)

        visit merchants_path

        within '#top-cities' do
          expect(page).to have_content("Denver")
          expect(page).to have_content("Total Orders: 3")
          expect(page).to have_content("Cheyenne")
          expect(page).to have_content("Total Orders: 2")
          expect(page).to have_content("Hartford")
          expect(page).to have_content("Total Orders: 1")
          expect(page).to_not have_content("Minneapolis")
        end
      end

      it 'top 3 biggest orders plus their quantities' do
        order_1 = create(:shipped_order)
        order_2 = create(:shipped_order)
        order_3 = create(:shipped_order)
        order_4 = create(:shipped_order)

        order_item_1 = create(:fulfilled_order_item, order: order_1, order_price: 3.0, order_quantity: 6, created_at: 6.days.ago, updated_at: 3.days.ago)
        order_item_2 = create(:fulfilled_order_item, order: order_2, order_price: 4.5, order_quantity: 2, created_at: 6.days.ago, updated_at: 1.days.ago)
        order_item_3 = create(:fulfilled_order_item, order: order_3, order_price: 6.0, order_quantity: 1, created_at: 6.days.ago, updated_at: 4.days.ago)
        order_item_4 = create(:fulfilled_order_item, order: order_4, order_price: 10.0, order_quantity: 5, created_at: 6.days.ago, updated_at: 5.days.ago)

        visit merchants_path
        
        within '#top-orders' do
          expect(page).to have_content(order_1.id)
          expect(page).to have_content("Total Quantity: 6")
          expect(page).to have_content(order_4.id)
          expect(page).to have_content("Total Quantity: 5")
          expect(page).to have_content(order_2.id)
          expect(page).to have_content("Total Quantity: 2")
          expect(page).to_not have_content(order_3.id)
        end
      end
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
