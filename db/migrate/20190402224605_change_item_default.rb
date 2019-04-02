class ChangeItemDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:items, :image, 'http://kriokrush.com.au/wp-content/uploads/2016/12/ComingSoon.jpg')
  end
end
