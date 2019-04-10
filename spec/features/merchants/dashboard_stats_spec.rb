require 'rails_helper'
RSpec.describe 'As a merchant', type: :feature do
  before(:each) do
    @admin = create(:admin)
    @user_1 = create(:user, state: "CO", city: "Denver", name: "Tim")
    @user_2 = create(:user, state: "CO", city: "Denver", name: "Tanya")
    @user_3 = create(:user, state: "CO", city: "Denver", name: "Todd")
    @user_4 = create(:user, state: "MA", city: "Boston", name: "Trish")
    @user_5 = create(:user, state: "MA", city: "Boston", name: "Tabitha")
    @user_6 = create(:user, state: "OR", city: "Portland", name: "Tony")
    @merchant = create(:merchant)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

    @item_1 = create(:item, user: @merchant, inventory: 100, name: "Tomato")
    @item_2 = create(:item, user: @merchant, inventory: 100, name: "Lemon")
    @item_3 = create(:item, user: @merchant, inventory: 100, name: "Zucchini")
    @item_4 = create(:item, user: @merchant, inventory: 100, name: "Peach")
    @item_5 = create(:item, user: @merchant, inventory: 100, name: "Turnip")
    @item_6 = create(:item, user: @merchant, inventory: 100, name: "Pear")
    @item_7 = create(:item, user: @merchant, inventory: 100, name: "Plum")
    # create_list(:item, 10, user: @merchant, inventory: 100)

    @inactive_item_1 = create(:inactive_item, user: @merchant)

    Random.new_seed
    rng = Random.new

    # pending order, none fulfilled
    @order_1 = create(:order, user: @user_1)
    @order_item_1 = create(:order_item, order: @order_1, item: @item_1, order_price: 2.5, order_quantity: 5)
    @order_item_2 = create(:order_item, order: @order_1, item: @item_2, order_price: 2, order_quantity: 5)

    # pending order, partially fulfilled
    @order_2 = create(:order, user: @user_2)
    @order_item_3 = create(:order_item, order: @order_2, item: @item_1, order_price: 2.5, order_quantity: 5)
    @order_item_4 = create(:fulfilled_order_item, order: @order_2, item: @item_2, order_price: 2, order_quantity: 5, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago)

    # packaged order
    @order_3 = create(:packaged_order, user: @user_1)
    @order_item_5 = create(:fulfilled_order_item, order: @order_3, item: @item_1, order_price: 2.5, order_quantity: 4, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
    @order_item_6 = create(:fulfilled_order_item, order: @order_3, item: @item_2, order_price: 2, order_quantity: 3, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

    # shipped order, cannot be cancelled
    @order_4 = create(:shipped_order, user: @user_4)
    @order_item_7 = create(:fulfilled_order_item, order: @order_4, item: @item_1, order_price: 1, order_quantity: 6, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
    @order_item_8 = create(:fulfilled_order_item, order: @order_4, item: @item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

    # cancelled order
    @order_5 = create(:cancelled_order, user: @user_5)
    @order_item_9 = create(:order_item, order: @order_5, item: @item_1, order_price: 2, order_quantity: 3, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
    @order_item_10 = create(:order_item, order: @order_5, item: @item_2, order_price: 3, order_quantity: 7, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
    #set 2 =====================================================================================================================
    # pending order, none fulfilled
    @order_6 = create(:order, user: @user_6)
    @order_item_11 = create(:order_item, order: @order_6, item: @item_3, order_price: 1, order_quantity: 11)
    @order_item_12 = create(:order_item, order: @order_6, item: @item_4, order_price: 2, order_quantity: 10)

    # pending order, partially fulfilled
    @order_7 = create(:order, user: @user_1)
    @order_item_13 = create(:order_item, order: @order_7, item: @item_3, order_price: 2.75, order_quantity: 8)
    @order_item_14 = create(:fulfilled_order_item, order: @order_7, item: @item_4, order_price: 2, order_quantity: 9, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago)

    # packaged order
    @order_8 = create(:packaged_order, user: @user_2)
    @order_item_15 = create(:fulfilled_order_item, order: @order_8, item: @item_3, order_price: 2.75, order_quantity: 4, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
    @order_item_16 = create(:fulfilled_order_item, order: @order_8, item: @item_4, order_price: 2, order_quantity: 24, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

    # shipped order, cannot be cancelled
    @order_9 = create(:shipped_order, user: @user_6)
    @order_item_17 = create(:fulfilled_order_item, order: @order_9, item: @item_3, order_price: 2.75, order_quantity: 76, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
    @order_item_18 = create(:fulfilled_order_item, order: @order_9, item: @item_4, order_price: 2, order_quantity: 33, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

    # cancelled order
    @order_10 = create(:cancelled_order, user: @user_4)
    @order_item_19 = create(:order_item, order: @order_10, item: @item_3, order_price: 2, order_quantity: 22, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
    @order_item_20 = create(:order_item, order: @order_10, item: @item_4, order_price: 3, order_quantity: 66, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
    #set 3 =====================================================================================================================
    # pending order, none fulfilled
    @order_11 = create(:order, user: @user_5)
    @order_item_21 = create(:order_item, order: @order_11, item: @item_5, order_price: 2.75, order_quantity: 77)
    @order_item_22 = create(:order_item, order: @order_11, item: @item_6, order_price: 2, order_quantity: 9)

    # pending order, partially fulfilled
    @order_12 = create(:order, user: @user_6)
    @order_item_23 = create(:order_item, order: @order_12, item: @item_5, order_price: 1, order_quantity: 55)
    @order_item_24 = create(:fulfilled_order_item, order: @order_12, item: @item_6, order_price: 2, order_quantity: 15, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago)

    # packaged order
    @order_13 = create(:packaged_order, user: @user_1)
    @order_item_25 = create(:fulfilled_order_item, order: @order_13, item: @item_5, order_price: 3, order_quantity: 25, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
    @order_item_26 = create(:fulfilled_order_item, order: @order_13, item: @item_6, order_price: 2, order_quantity: 35, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

    # shipped order, cannot be cancelled
    @order_14 = create(:shipped_order, user: @user_2)
    @order_item_27 = create(:fulfilled_order_item, order: @order_14, item: @item_5, order_price: 1, order_quantity: 35, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
    @order_item_28 = create(:fulfilled_order_item, order: @order_14, item: @item_6, order_price: 2, order_quantity: 45, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

    # cancelled order
    @order_15 = create(:cancelled_order, user: @user_3)
    @order_item_29 = create(:order_item, order: @order_15, item: @item_5, order_price: 2, order_quantity: 45, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
    @order_item_30 = create(:order_item, order: @order_15, item: @item_6, order_price: 3, order_quantity: 55, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

    @items = [@item_1,@item_2,@item_3,@item_4,@item_5,@item_6,@item_7]
    @orders = [@order_1,@order_2,@order_3,@order_4,@order_5,@order_6,@order_7,@order_8,@order_9,@order_10]
    @order_items = [@order_item_1,@order_item_2,@order_item_3,@order_item_4,@order_item_5,@order_item_6,@order_item_7,@order_item_8,@order_item_9,@order_item_10,@order_item_11,@order_item_12,@order_item_13,@order_item_14,@order_item_15,@order_item_16,@order_item_17,@order_item_18,@order_item_19,@order_item_20,@order_item_21,@order_item_22,@order_item_23,@order_item_24,@order_item_25,@order_item_26,@order_item_27,@order_item_28,@order_item_29,@order_item_30]
    @total_inventory = @items.sum { |item| item.inventory }
    @order_items.count
    @total_ordered_quantity = @order_items.sum { |order_item| order_item.order_quantity }
    @percentage_sold = (@total_ordered_quantity.to_f / @total_inventory)*100
    @sorted_quantity_sold = @order_items.sort_by { |order_item| order_item.order_quantity }
    @Top_5_Items_Sold = @sorted_quantity_sold.last(5)
    # binding.pry
    end

  describe 'When I visit my dashboard, I see an area with statistics' do
    it 'top 5 items I have sold by quantity, and the quantity of each that Ive sold' do
      visit dashboard_path

      expect(page).to have_content("Top 5 Items Sold Turnip: 237 Pear: 159 Peach: 142 Zucchini: 121 Tomato: 23")
    end
    it 'total quantity of items Ive sold, and as a percentage against my sold units plus remaining inventory' do
      visit dashboard_path
      expect(page).to have_content("Sold #{@total_ordered_quantity} items, which is 23.0% of your total inventory")
    end #Sold 1000 items, which is 10% of your total inventory
    it 'top 3 states where my items were shipped, and their quantities' do
      visit dashboard_path
      expect(page).to have_content("CO: 16.0 MA: 8.0 OR: 6.0")
    end
    it 'top 3 city/state where my items were shipped, and their quantities (Springfield, MI should not be grouped with Springfield, CO)' do
      visit dashboard_path
      expect(page).to have_content("Denver, CO: 16.0 Boston, MA: 8.0 Portland, OR: 6.0")
  end
    it 'name of the user with the most orders from me (pick one if theres a tie), and number of orders' do
      visit dashboard_path
      expect(page).to have_content("Top Purchaser by Orders: Tim - 8.0")
    end
    it 'name of the user who bought the most total items from me (pick one if theres a tie), and the total quantity' do
      visit dashboard_path
      expect(page).to have_content("Top Purchaser by Quantity: Tony - 200.0")
    end
    it 'top 3 users who have spent the most money on my items, and the total amount theyve spent' do
      visit dashboard_path
      expect(page).to have_content("Top Spenders: Tim $18.75 Tanya $12.25 Tony $10.75")
    end
  end
end
