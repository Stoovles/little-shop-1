class CreateJoinTableUserCoupon < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :coupons do |t|
      # t.index [:user_id, :coupon_id]
      # t.index [:coupon_id, :user_id]
      t.references :user, foreign_key: true
      t.references :coupon, foreign_key: true

    end
  end
end
