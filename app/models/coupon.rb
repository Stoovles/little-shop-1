class Coupon < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :discount, :amount, :active

  enum discount: ["dollar", "percent"]
end
