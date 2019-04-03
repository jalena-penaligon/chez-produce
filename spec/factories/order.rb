FactoryBot.define do
  factory :order, class: Order do
    user
    status { :pending }
  end
  factory :packaged_order, parent: :order do
    user
    status { :packaged }
  end
  factory :shipped_order, parent: :order do
    user
    status { :shipped }
  end
  factory :cancelled_order, parent: :order do
    user
    status { :cancelled }
  end
end
