class Order 
  attr_reader :id 
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id 
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    fulfillment_valid_status = [:paid, :processing, :shipped, :complete, :pending]
    raise ArgumentError if !fulfillment_valid_status.include?(fulfillment_status)
  end 
  def total
    tax = 0.075
    sum_values = products.values.sum 
    total_price = sum_values + (sum_values * tax)
    return total_price.round(2)
  end 

  def add_product(name, price)
    raise ArgumentError if products.key?(name)
    products[name] = price
  end


end 


