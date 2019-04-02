class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :email_address
      t.string :password_digest
      t.string :password_confirmation
      t.integer :role

      t.timestamps
    end
  end
end
