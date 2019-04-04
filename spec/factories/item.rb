FactoryBot.define do
  factory :item do
    association :user, factory: :merchant
    sequence(:name) { |n| "Item Name #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:image) { |n| "http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg?image=#{n}" }
    sequence(:current_price) { |n| ("#{n}".to_i+1)*1.5 }
    sequence(:inventory) { |n| ("#{n}".to_i+1)*2 }
    active { true }
    created_at { 5.days.ago }
  end

  factory :inactive_item, parent: :item do
    association :user, factory: :merchant
    sequence(:name) { |n| "Inactive Item Name #{n}" }
    active { false }
  end
end
