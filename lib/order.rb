class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    unless valid_status.include?(fulfillment_status)
      raise ArgumentError.new "#{fulfillment_status} is not a valid status."
    end
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    total = (@products.sum { |product, price| price * 1.075}).round(2)
    return total
  end

  def add_product(name, price)
    if @products.has_key?(name)
      raise ArgumentError.new "The product #{name} is already added to the order!"
    else
      @products[name] = price
    end
  end

  def remove_product(name)
    if @products.has_key?(name)
      @products.delete(name)
    else
      raise ArgumentError.new "The product #{name} is not present in the order."
    end
  end

end