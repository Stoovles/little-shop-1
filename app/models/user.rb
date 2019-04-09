class User < ApplicationRecord
  attr_accessor :skip_password_validation
  has_many :items
  has_many :orders


  has_secure_password allow_blank: true
  validates :password, confirmation: true
  validates_presence_of :name, :street_address, :city, :state, :zip_code, :email_address
  validates_uniqueness_of :email_address
  #validates :password_confirmation, presence: true


  enum role: ['user', 'merchant', 'admin']

  def self.active_merchant
    where(role: 1, enabled: true)
  end

  # # e.g., User.authenticate('penelope@turing.com', 'boom')
  # def self.authenticate(email, password)
  #   if self.find_by(email_address: email) == self.find_by(password: password)
  #     self.find_by(email_address: email)
  #   else
  #     nil
  #   end
  # # if email and password correspond to a valid user, return that user
  # # otherwise, return nil
  # end

  def my_item_count(order)
    OrderItem.where(item_id: self.items, order_id: order.id).sum(:quantity)
  end

  def my_total(order)
    OrderItem.where(item_id: self.items, order_id: order.id).sum("quantity*order_price")
  end

  def merchant_pending_orders
    ids = OrderItem.where(item_id: self.items,fulfilled: false).pluck(:order_id)
    Order.where(id: ids)
    # REFACTORRR
  end

  def total_inventory
    items.sum(:inventory)
  end

  def total_quantity_sold
    items.joins(:order_items).where("order_items.fulfilled = true").sum(:quantity)
  end

  def percentage_sold
    (total_quantity_sold / (total_inventory + total_quantity_sold).to_f) * 100
  end

  def top_three_states
    binding.pry
  end


end
