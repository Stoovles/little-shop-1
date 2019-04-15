class Cart
  attr_reader :contents


  def initialize(contents)
    @contents = contents || Hash.new(0)
    @contents.default = 0
  end

  def items
    Item.where(id: @contents.keys)
  end

  def discounted_items(coupon)
    Item.where(user_id: coupon["user_id"]).where(id: self.items.pluck(:id))
  end

  # def non_discounted_items(coupon)
  #   Item.where.not(user_id: coupon["user_id"]).where(id: self.items.pluck(:id))
  #
  # end

  def total_count
    @contents.values.sum if @contents
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def add_item(item_id)
    @contents[item_id.to_s] += 1
  end

  def subtotal(item)
    @contents[item.id.to_s] * item.current_price
  end

  def discounted_subtotal(item, coupon)
    @contents[item.id.to_s] * self.discount_price(item, coupon)
  end

  def discount_price(item, coupon)
    item.current_price - (item.current_price * (coupon["discount"].to_f/100))
  end

  def cart_total
    items.inject(0) do |total, item|
      total += subtotal(item)
    end
  end

  def discounted_cart_dif(coupon)
    discounted_items(coupon).inject(0) do |total, item|
      total += (self.subtotal(item) - self.discounted_subtotal(item, coupon))
      total
    end
  end

  def discounted_cart_total(coupon)
    cart_total - discounted_cart_dif(coupon)
  end

  # def cart_discount_total(coupon)
  #   discounted_items(coupon).inject(0) do |total, item|
  #     total += discounted_subtotal(item, coupon)
  #   end
  # end

  # def cart_non_discount_total(coupon)
  #   non_discounted_items(coupon).inject(0) do |total, item|
  #     total += subtotal(item)
  #   end
  # end

  # def cart_full_total(coupon)
  #   cart_discount_total(coupon) + cart_total
  # end

  def discounted?(session, item)
    session.key?("coupon") && item.user_id == session[:coupon]["user_id"]
  end

end
