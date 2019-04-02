class ChangeUser < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :active, true)
    change_column_default(:users, :role, 0)
  end
end
