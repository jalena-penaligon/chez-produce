require 'rails_helper'
RSpec.describe 'As any kind of user on the system' do
  describe "I can visit the items catalog (items)" do
    it 'I see all items in the system except disabled items' do
      sally = User.create(name:"sallyFields", role: 2, password: "salad", email:"f@g.com")
      item1 = sally.items.create(name:"grapes", inventory: 10, current_price: 1.50, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg")
      tim = User.create!(name:"timFields", role: 2, password: "salad", email:"fields2@g.com")
      item2 = tim.items.create(name:"zucchini", inventory: 5, current_price: 2.00, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg")
      item3 = sally.items.create(name:"bananas", inventory: 5, current_price: 1.50, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg")
      visit items_path
      expect(page).to have_content(sally.name)
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.inventory)
      expect(page).to have_content(item1.current_price)
      # expect(page).to have_xpath("//img[@src='http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg']")
      expect(page).to have_content(item3.name)
      expect(page).to have_content(item3.inventory)
      expect(page).to have_content(item3.current_price)
      expect(page).to have_content(tim.name)
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item2.inventory)
      expect(page).to have_content(item2.current_price)
      # find(:xpath, "//a/img[@alt='#{item2.image}']/..").click
      # find(:xpath, "//a/img[@alt=''#{item.image}"/..").click click_link("item_path("#{item1.id}")")
      # click_on item_path|("#{item1.name}")
      # click_on item_path|("#{item2.image}")
      # click_on item_path|("#{item2.image}")
    end
  end
end
