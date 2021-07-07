
require 'csv'
require_relative 'customer'

# Class that holds information on order
class Order
  # Constants for order's status
  VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]
  
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    
    # Check for valid order status
    raise ArgumentError, "Status is bogus" unless VALID_STATUS.include?(@fulfillment_status)
  end
  
  # Calculate order's total with tax
  def total   
    return 0 if @products.empty?

    (@products.values.sum * 1.075).round(2)
  end
  
  # Add product to order
  def add_product(product_name, product_price)
    raise ArgumentError, "That was already ordered" if @products.keys.include?(product_name)
    
    @products["#{product_name}"] = product_price
  end
  
  # Load data from CSV
  def self.all
    file = CSV.read('data/orders.csv').map(&:to_a)
    
    all_orders = file.map do |new_c|      
      Order.new(new_c[0].to_i, products_to_hash(new_c[1]), Customer.find(new_c[2].to_i), new_c[3].to_sym)
    end
  end
  
  # Return order with order id
  def self.find(id)
    all_orders = Order.all
    
    selected_order = all_orders.find { |order| order.id == id }
  end
  
  # Parse list of products into hash
  def self.products_to_hash(products_as_string)
    products_hash = {}
    products_array = products_as_string.split(';')
    
    products_array.each do |product|
      product_array = product.split(':')
      products_hash[product_array[0]] = product_array[1].to_f
    end
    
    return products_hash
  end
end