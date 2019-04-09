class AddsDefaultImageToItem < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :image_url, :string, :default => "https://www.lawlersliquorsonline.com/wp-content/uploads/2018/10/Blank-Bottle-88.png"
  end
end
