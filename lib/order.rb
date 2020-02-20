class Order
  attr_reader :id
  attr_accessor :products, :fulfillment_status, :customer

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError.new unless [:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
    
    @id = id
    @customer = customer
    @products = products
    @fulfillment_status = fulfillment_status
  end

  def total
    return 0 if products == {}
    total = products.values.reduce(:+)
    tax = total * 0.075
    total = total + tax
    return total.round(2)
  end

  def add_product(name, price)
    raise ArgumentError.new if products.keys.include? name
    @products[name] = price 
    return @products 
  end
end