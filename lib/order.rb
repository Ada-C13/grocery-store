# order.rb 

require_relative "customer.rb"

  # helper method 
  def convert_to_hash(string)
    pairs = string.split(";")
    pairs2 = pairs.map{ |pair| pair.split(":")}
    pairs2.each do |pair|
      pair[1] = pair[1].to_f
    end 
    return pairs2.to_h
  end

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


  def self.all
    all_orders = []
    CSV.read("../data/orders.csv").each do |order|
      ordered_products = convert_to_hash(order[1])
      customer = Customer.find(order[2].to_i)
      unique_order = Order.new(order[0].to_i, ordered_products, customer, order[3].to_sym)
      all_orders << unique_order
    end
    return all_orders
  end

  def self.find(id)

  end 

end 