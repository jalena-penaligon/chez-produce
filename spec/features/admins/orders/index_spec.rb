require 'rails_helper'
RSpec.describe "As an admin user" do
  before :each do
    @user = create(:user)
    @user_2 = create(:user)
    @admin= create(:user, role:2)
    @merchant_1, @merchant_2 = create_list(:merchant, 2)
    @item_1 = create(:item, user: @merchant_1, inventory: 1)
    @item_2 = create(:item, user: @merchant_2)
    @item_3 = create(:item, user: @merchant_1, inventory: 0)
    # shipped order, cannot be cancelled
    @order_1 = create(:shipped_order, user: @user)
    @order_item_1 = create(:fulfilled_order_item, order: @order_1, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    @order_item_2 = create(:fulfilled_order_item, order: @order_1, item: @item_2, order_price: 2, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    @order_2 = create(:shipped_order, user: @user_2)
    @order_item_3 = create(:fulfilled_order_item, order: @order_2, item: @item_1, order_price: 1, order_quantity: 1, created_at: 4.days.ago, updated_at: 1.days.ago)
    # pending order, none fulfilled
    @order_3 = create(:order, user: @user_2)
    @order_item_4 = create(:order_item, order: @order_3, item: @item_1, order_price: 1, order_quantity: 1)
    @order_item_5 = create(:order_item, order: @order_3, item: @item_2, order_price: 2, order_quantity: 1)
    # packaged order
    @order_5 = create(:packaged_order, user: @user)
    @order_item_8 = create(:fulfilled_order_item, order: @order_5, item: @item_2, order_price: 1, order_quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)
    @order_item_9 = create(:fulfilled_order_item, order: @order_5, item: @item_3, order_price: 2, order_quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)
    # cancelled order
    @order_6 = create(:cancelled_order, user: @user)
    create(:order_item, order: @order_6, item: @item_2, order_price: 2, order_quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)
    create(:order_item, order: @order_6, item: @item_3, order_price: 3, order_quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)

end
  describe "When I log into my dashboard, /admin/dashboard" do
    it 'can see all orders in the system' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_dashboard_path

      within "#order-#{@order_1.id}" do
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
      end
      within "#order-#{@order_2.id}" do
        expect(page).to have_content(@user_2.name)
        expect(page).to have_content(@order_2.id)
        expect(page).to have_content(@order_2.created_at)
      end
      expect(page.all(".orders")[0]).to have_content("#{@order_5.id}")
      expect(page.all(".orders")[1]).to have_content("#{@order_3.id}")
      expect(page.all(".orders")[2]).to have_content("#{@order_1.id}")
      expect(page.all(".orders")[3]).to have_content("#{@order_2.id}")
      expect(page.all(".orders")[4]).to have_content("#{@order_6.id}")

      within "#order-#{@order_2.id}" do
        click_on "#{@user_2.name}"
      end
      expect(current_path).to eq(admin_user_path(@user_2.id))
    end

    it 'I see any "packaged" orders ready to ship' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      user = create(:user)
      merchant_1, merchant_2 = create_list(:merchant, 2)
      item_1 = create(:item, user: merchant_1, inventory: 1)
      item_2 = create(:item, user: merchant_2)
      # packaged order
      order = create(:packaged_order, user: user, status: 0)
      order_item_8 = create(:fulfilled_order_item, order: order, item: item_2, order_price: 1, order_quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)
      order_item_9 = create(:fulfilled_order_item, order: order, item: item_1, order_price: 2, order_quantity: 1, created_at: 5.days.ago, updated_at: 1.days.ago)
      visit admin_dashboard_path
        # within (page.all(".orders")[1]) do#{}"#order-#{order.id}"
        within ("#order-#{order.id}") do
          expect(order.status).to eq("packaged")
          click_on "Ship"
          expect(current_path).to eq(admin_dashboard_path)
        end
          # binding.pry
          within "#order-#{order.id}" do
            order = Order.find(order.id)
            expect(order.status).to eq("shipped")
            expect(page).to have_content("shipped")
            # expect(order.status).to eq("shipped")
            expect(page).to_not have_content("Cancel")
          end
      end
    end
  end
