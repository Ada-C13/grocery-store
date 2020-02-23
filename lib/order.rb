class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_states = [:pending, :paid, :processing, :shipped, :complete]
    @id = id
    @products = products 
    @customer = customer
    @fulfillment_status = fulfillment_status
    raise ArgumentError unless valid_states.include?(fulfillment_status)
  end 

  def total
    order_total = 0
    @products.each do |name, price|
      order_total += price 
    end 
    order_total = order_total * 1.075
    order_total = order_total.round(2)
  end 

  def add_product(name, price)
    if @products.include? name
      raise ArgumentError.new("That item is already in your cart.")
    else
      @products.store(name, price)
    end
  end 
end