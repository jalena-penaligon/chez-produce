require 'rails_helper'
RSpec.describe 'As any kind of user on the system' do
  describe "I can visit the items catalog (items)" do
    it 'I see all items in the system except disabled items' do
      sally = User.create(name:"sallyFields", role: 2, password: "salad", email:"f@g.com")
      item1 = sally.items.create(name:"grapes", inventory: 10, current_price: 1.50, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg")
      tim = User.create!(name:"timFields", role: 2, password: "salad", email:"fields2@g.com")
      item2 = tim.items.create(name:"zucchini", inventory: 5, current_price: 2.00, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg")
      item3 = sally.items.create(name:"bananas", inventory: 5, current_price: 1.50, active: true, image: "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg")
      visit items_path
    
      expect(page).to have_content(sally.name)
      expect(page).to have_content(item1.name)
      expect(page).to have_content(item1.inventory)
      expect(page).to have_content(item1.current_price)
      expect(page).to have_content(item3.name)
      expect(page).to have_content(item3.inventory)
      expect(page).to have_content(item3.current_price)
      expect(page).to have_content(tim.name)
      expect(page).to have_content(item2.name)
      expect(page).to have_content(item2.inventory)
      expect(page).to have_content(item2.current_price)
      expect(page).to have_css("img[src*='#{item1.image}']")
      expect(page).to have_css("img[src*='#{item2.image}']")
      expect(page).to have_css("img[src*='#{item3.image}']")
    end
  end
end
