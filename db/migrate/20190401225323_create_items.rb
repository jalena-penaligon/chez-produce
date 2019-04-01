class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image
      t.text :description
      t.integer :inventory
      t.float :current_price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
