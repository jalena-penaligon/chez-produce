OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

u_01 = User.create(name: "Michael Foreman", street_address: "1066 Birch Street" , city: "Indianapolis", state: "IN", zipcode: "46278", email: "mforeman@produce.com", password: "orange123")
u_02 = User.create(name: "Jose Kent", street_address: "1668 Crestview Terrace" , city: "Pleasanton", state: "TX", zipcode: "74135", email: "jkent@produce.com", password: "apple123")
u_03 = User.create(name: "Barbara Clayton", street_address: "3419 Heliport Loop" , city: "Leavenworth", state: "IN", zipcode: "47137", email: "bkent@produce.com", password: "avocado123")
u_04 = User.create(name: "Anya Nambisan", street_address: "4163 Bottom Lane" , city: "Buffalo", state: "NY", zipcode: "14202", email: "anambisan@produce.com", password: "kale123")
u_05 = User.create(name: "Luiza Grabowska", street_address: "1000 School Street" , city: "Danbury", state: "CT", zipcode: "06810", email: "lgrabowska@produce.com", password: "banana123")
u_06 = User.create(name: "Russell Zwager", street_address: "3019 Cambridge Drive" , city: "Peoria", state: "AZ", zipcode: "85382", email: "rzwagar@produce.com", password: "pineapple123")
u_07 = User.create(name: "Sheng Fan", street_address: "1356 Providence Lane" , city: "Pleasanton", state: "TX", zipcode: "74135", email: "sfan@produce.com", password: "pineapple123")
u_08 = User.create(name: "Viollette Pouliotte", street_address: "3673 Jennifer Lane" , city: "Buffalo", state: "NY", zipcode: "14202", email: "vpouliotte@produce.com", password: "tomato123")
u_09 = User.create(name: "Swen Keller", street_address: "2635 Hillview Drive" , city: "Buffalo", state: "NY", zipcode: "14202", email: "skeller@produce.com", password: "spinach123")
u_10 = User.create(name: "Scarlett Spencer", street_address: "1333 Layman Court" , city: "Denver", state: "CO", zipcode: "80207", email: "sspencer@produce.com", password: "peach123")

admin = User.create(name: "Admin", street_address: "1331 17th Street" , city: "Denver", state: "CO", zipcode: "80202", email: "admin@chezproduce.com", password: "admin", role: 2)

m_01 = User.create(name: "Sam's Produce", street_address: "5105 Cook St" , city: "Denver", state: "CO", zipcode: "80216", email: "sams@samsproduce.com", password: "fruity", role: 1)
m_02 = User.create(name: "JM Farms", street_address: "415 Yuma St" , city: "Denver", state: "CO", zipcode: "80204", email: "yuma@yumafarms.com", password: "vegetables", role: 1)
m_03 = User.create(name: "Fresh Start Produce Too", street_address: "3225 Denargo St" , city: "Denver", state: "CO", zipcode: "80216", email: "freshstart@freshstartproducetoo.com", password: "bountiful", role: 1)
m_04 = User.create(name: "Fresh Guys Produce", street_address: "1890 E 58th Ave" , city: "Denver", state: "CO", zipcode: "80216", email: "freshguys@freshguysproduce.com", password: "fresh", role: 1)
m_05 = User.create(name: "Tucci Fresh Produce", street_address: "850 E 50th Ave A" , city: "Denver", state: "CO", zipcode: "80216", email: "tucci@tuccifreshproduce.com", password: "tucci", role: 1)
m_06 = User.create(name: "American Produce", street_address: "5151 Bannock St # 3" , city: "Denver", state: "CO", zipcode: "80216", email: "american@americanproduce.com", password: "fruity", role: 1)
m_07 = User.create(name: "Growers Organic", street_address: "6400 Broadway # 11" , city: "Denver", state: "CO", zipcode: "80221", email: "growers@growersorganic.com", password: "veggie", role: 1)
m_08 = User.create(name: "Paradigm Fresh", street_address: "4823 Lima St B" , city: "Denver", state: "CO", zipcode: "80239", email: "paradigm@paradigmfresh.com", password: "veggie", role: 1)

it_01 = m_01.items.create(name: "Apple", description: "Gala Apple, One Medium. Organic, natural, can be stored in refrigerators.", inventory: 15, current_price: 0.50, active: true)
it_02 = m_01.items.create(name: "Avocado", description: "Hass Avocado, One Large. Grown in Mexico or California.", inventory: 7, current_price: 1.42, active: true)
it_03 = m_02.items.create(name: "Bananas", description: "One bunch contains approximately 5-7 bananas. Grown in Ecuador or Costa Rica or Guatemala.", inventory: 21, current_price: 1.79, active: true)
it_04 = m_02.items.create(name: "Blackberries", description: "Blackberries, 6 oz. Grown in United States, Chile, or Mexico.", inventory: 14, current_price: 2.99, active: true)
it_05 = m_03.items.create(name: "Blueberries", description: "Organic Blueberries, 6 oz. Grown in United States, Mexico, Peru, Chile, Argentina and Canada.", inventory: 12, current_price: 3.99, active: true)
it_06 = m_03.items.create(name: "Brussel Sprouts", description: "Brussels Sprouts, 12 oz Bag. Pre-washed.", inventory: 21, current_price: 2.99, active: true)
it_07 = m_03.items.create(name: "Carrots", description: "Organic Carrots, 1 lb. Grown in United States or Mexico.", inventory: 28, current_price: 0.99, active: true)
it_08 = m_04.items.create(name: "Garlic", description: "Organic Garlic, One Medium. Grown in United State, Argentina, Mexico, Spain, or China.", inventory: 42, current_price: 1.99, active: true)
it_09 = m_04.items.create(name: "Kale", description: "Organic Kale, One Bunch. Grown in United States or Mexico.", inventory: 17, current_price: 2.99, active: true)
it_10 = m_05.items.create(name: "Orange", description: "Navel Orange, One Medium. Grown in United States. Easy to peel.", inventory: 22, current_price: 0.79, active: true)
it_11 = m_05.items.create(name: "Pineapple", description: "Gold Pineapple, One Medium. Organic, natural, can be stored in refrigerators.", inventory: 11, current_price: 2.50, active: true)
it_12 = m_06.items.create(name: "Pomegranate", description: "Pomegranate, One Medium. Grown in northern India.", inventory: 4, current_price: 2.99, active: true)
it_13 = m_07.items.create(name: "Spinach", description: "Organic Baby Spinach, 16 oz. Triple-washed.", inventory: 19, current_price: 4.99, active: true)
it_14 = m_07.items.create(name: "Tomato", description: "Organic Roma Tomatoes, 1.5 lb. Grown in United States or Mexico.", inventory: 24, current_price: 3.99, active: true)
it_15 = m_08.items.create(name: "Yellow Bell Pepper", description: "Organic Yellow Bell Pepper, One Medium.", inventory: 31, current_price: 2.29, active: true)

o_01 = u_01.orders.create(status: 0)
oi_01 = OrderItem.create(order_id: o_01.id, item_id: it_01.id, order_price: 0.50, order_quantity: 3, fulfilled: false)
oi_02 = OrderItem.create(order_id: o_01.id, item_id: it_02.id, order_price: 1.42, order_quantity: 4, fulfilled: false)

o_02 = u_02.orders.create(status: 1)
oi_03 = OrderItem.create(order_id: o_02.id, item_id: it_03.id, order_price: 1.79, order_quantity: 2, fulfilled: false)

o_03 = u_03.orders.create(status: 2)
oi_04 = OrderItem.create(order_id: o_03.id, item_id: it_04.id, order_price: 2.99, order_quantity: 5, fulfilled: true)
oi_05 = OrderItem.create(order_id: o_03.id, item_id: it_05.id, order_price: 3.99, order_quantity: 2, fulfilled: true)

o_04 = u_04.orders.create(status: 3)
oi_06 = OrderItem.create(order_id: o_04.id, item_id: it_06.id, order_price: 2.99, order_quantity: 3, fulfilled: false)

o_05 = u_05.orders.create(status: 0)
oi_07 = OrderItem.create(order_id: o_05.id, item_id: it_07.id, order_price: 0.99, order_quantity: 2, fulfilled: false)
oi_08 = OrderItem.create(order_id: o_05.id, item_id: it_08.id, order_price: 1.99, order_quantity: 3, fulfilled: false)
oi_09 = OrderItem.create(order_id: o_05.id, item_id: it_09.id, order_price: 2.99, order_quantity: 7, fulfilled: false)

o_06 = u_06.orders.create(status: 1)
oi_10 = OrderItem.create(order_id: o_06.id, item_id: it_10.id, order_price: 0.79, order_quantity: 3, fulfilled: false)
oi_11 = OrderItem.create(order_id: o_06.id, item_id: it_11.id, order_price: 2.50, order_quantity: 5, fulfilled: false)

o_07 = u_07.orders.create(status: 2)
oi_12 = OrderItem.create(order_id: o_07.id, item_id: it_12.id, order_price: 2.99, order_quantity: 2, fulfilled: true)
oi_13 = OrderItem.create(order_id: o_07.id, item_id: it_13.id, order_price: 4.99, order_quantity: 1, fulfilled: true)

o_08 = u_08.orders.create(status: 3)
oi_14 = OrderItem.create(order_id: o_08.id, item_id: it_14.id, order_price: 3.99, order_quantity: 7, fulfilled: false)
oi_15 = OrderItem.create(order_id: o_08.id, item_id: it_15.id, order_price: 2.29, order_quantity: 2, fulfilled: false)

o_09 = u_09.orders.create(status: 0)
oi_16 = OrderItem.create(order_id: o_09.id, item_id: it_01.id, order_price: 0.50, order_quantity: 3, fulfilled: false)
oi_17 = OrderItem.create(order_id: o_09.id, item_id: it_02.id, order_price: 1.42, order_quantity: 5, fulfilled: false)

o_10 = u_10.orders.create(status: 1)
oi_18 = OrderItem.create(order_id: o_10.id, item_id: it_03.id, order_price: 1.79, order_quantity: 5, fulfilled: false)

o_11 = u_01.orders.create(status: 3)
oi_19 = OrderItem.create(order_id: o_01.id, item_id: it_01.id, order_price: 0.50, order_quantity: 3, fulfilled: true)
oi_20 = OrderItem.create(order_id: o_01.id, item_id: it_02.id, order_price: 1.42, order_quantity: 4, fulfilled: true)

o_12 = u_02.orders.create(status: 3)
oi_21 = OrderItem.create(order_id: o_02.id, item_id: it_03.id, order_price: 1.79, order_quantity: 2, fulfilled: true)

o_13 = u_04.orders.create(status: 3)
oi_22 = OrderItem.create(order_id: o_04.id, item_id: it_06.id, order_price: 2.99, order_quantity: 3, fulfilled: true)

o_14 = u_05.orders.create(status: 3)
oi_23 = OrderItem.create(order_id: o_05.id, item_id: it_07.id, order_price: 0.99, order_quantity: 2, fulfilled: true)
oi_24 = OrderItem.create(order_id: o_05.id, item_id: it_08.id, order_price: 1.99, order_quantity: 3, fulfilled: true)
oi_25 = OrderItem.create(order_id: o_05.id, item_id: it_09.id, order_price: 2.99, order_quantity: 7, fulfilled: true)



# require 'factory_bot_rails'
#
# include FactoryBot::Syntax::Methods
#
# admin = create(:admin)
# user = create(:user)
# merchant_1 = create(:merchant)
#
# merchant_2, merchant_3, merchant_4 = create_list(:merchant, 3)
#
# inactive_merchant_1 = create(:inactive_merchant)
# inactive_user_1 = create(:inactive_user)
#
# item_1 = create(:item, user: merchant_1)
# item_2 = create(:item, user: merchant_2)
# item_3 = create(:item, user: merchant_3)
# create_list(:item, 10, user: merchant_1)
#
# inactive_item_1 = create(:inactive_item, user: merchant_1)
# inactive_item_2 = create(:inactive_item, user: inactive_merchant_1)
#
# Random.new_seed
# rng = Random.new
#
# # pending order, none fulfilled
# order = create(:order, user: user)
# create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1)
# create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1)
#
# # pending order, partially fulfilled
# order = create(:order, user: user)
# create(:order_item, order: order, item: item_1, order_price: 1, order_quantity: 1)
# create(:fulfilled_order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago)
#
# # packaged order
# order = create(:packaged_order, user: user)
# create(:fulfilled_order_item, order: order, item: item_1, order_price: 1, order_quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
# create(:fulfilled_order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
#
# # shipped order, cannot be cancelled
# order = create(:shipped_order, user: user)
# create(:fulfilled_order_item, order: order, item: item_1, order_price: 1, order_quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
# create(:fulfilled_order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
#
# # cancelled order
# order = create(:cancelled_order, user: user)
# create(:order_item, order: order, item: item_2, order_price: 2, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
# create(:order_item, order: order, item: item_3, order_price: 3, order_quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
#
#
# puts 'seed data finished'
# puts "Users created: #{User.count.to_i}"
# puts "Orders created: #{Order.count.to_i}"
# puts "Items created: #{Item.count.to_i}"
# puts "OrderItems created: #{OrderItem.count.to_i}"
