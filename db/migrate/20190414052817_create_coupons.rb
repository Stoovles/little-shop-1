class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.decimal :discount
      t.boolean :enabled, :default => true
      t.boolean :used, :default => false

      t.timestamps
    end
  end
end
