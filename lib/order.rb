# order.rb 

require_relative "customer.rb"

class Order

  attr_accessor :products, :customer, :fulfillment_status 
  attr_reader :id
  VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer 

    if VALID_STATUS.include?(fulfillment_status) == false 
      raise ArgumentError.new("#{fulfillment_status} is an invalid fulfillment status.")
    end 

    @fulfillment_status = fulfillment_status 
  end 

  def total 
    product_sum = 0.00
    products.each do |item, cost|
      product_sum += cost
    end
    product_sum += product_sum*0.075
    return product_sum.round(2)
  end 

  def add_product(product_name, price)
    if products.has_key?(product_name.downcase) 
      raise ArgumentError.new("Cannot add #{product_name} because it is already in the order.") 
    end
    products[product_name] = price
  end

end 