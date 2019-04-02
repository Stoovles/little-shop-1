class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :item_name
      t.text :description
      t.string :image_url
      t.integer :inventory
      t.decimal :current_price
      t.boolean :enabled
      t.timestamps
    end
  end
end
