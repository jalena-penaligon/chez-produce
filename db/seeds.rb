require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

admin = create(:admin)
user = create(:user)
merchant_1 = create(:merchant)

merchant_2, merchant_3, merchant_4 = create_list(:merchant, 3)

inactive_merchant_1 = create(:inactive_merchant)
inactive_user_1 = create(:inactive_user)

item_1 = create(:item, user: merchant_1)
item_2 = create(:item, user: merchant_2)
create_list(:item, 10, user: merchant_1)

inactive_item_1 = create(:inactive_item, user: merchant_1)
inactive_item_2 = create(:inactive_item, user: inactive_merchant_1)

Random.new_seed
rng = Random.new

# pending order, none fulfilled
order = create(:order, user: user)
create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1)
create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1)

# pending order, partially fulfilled
order = create(:order, user: user)
create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago)

# packaged order
order = create(:packaged_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, order_price: 1, order_quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

# shipped order, cannot be cancelled
order = create(:shipped_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, order_price: 1, order_quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

# cancelled order
order = create(:cancelled_order, user: user)
create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: item_3, order_price: 3, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)


puts 'seed data finished'
puts "Users created: #{User.count.to_i}"
puts "Orders created: #{Order.count.to_i}"
puts "Items created: #{Item.count.to_i}"
puts "OrderItems created: #{OrderItem.count.to_i}"
