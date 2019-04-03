class Cart
  attr_reader :contents


  def initialize(contents)
    @contents = contents || Hash.new(0)
    @contents.default = 0
  end

  def total_count
    @contents.values.sum if @contents
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def add_item(item_id)
    @contents[item_id.to_s] += 1
  end

end
