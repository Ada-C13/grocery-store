#
require 'csv'
require_relative 'customer'

#
class Order
  VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]
  
  #
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  
  #
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    
    raise ArgumentError, "Fulfillment status not valid" unless VALID_STATUS.include?(@fulfillment_status)
  end
  
  #
  def total   
    return 0 if @products.empty?

    (@products.values.sum * 1.075).round(2)
  end
  
  # 
  def add_product(product_name, product_price)
    raise ArgumentError, "That was already ordered" if @products.keys.include?(product_name)
    
    @products["#{product_name}"] = product_price
  end
  
  # 
  def self.all
    file = CSV.read('data/orders.csv').map(&:to_a)
    
    all_orders = file.map do |new_c|      
      Order.new(new_c[0].to_i, products_to_hash(new_c[1]), Customer.find(new_c[2].to_i), new_c[3].to_sym)
    end
    
    return all_orders
  end
  
  # 
  def self.find(id)
    all_orders = Order.all
    
    selected_order = all_orders.find { |order| order.id == id }
    
    return selected_order
  end
  
  # 
  def self.products_to_hash(products_as_string)
    products_hash = {}
    products_array = products_as_string.split(';')
    
    products_array.each do |product|
      product_array = product.split(':')
      products_hash[product_array[0]] = product_array[1].to_f
    end
    
    return products_hash
  end
  
  # 
  def self.save(filename)
    all_orders = Order.all
    
    CSV.open(filename, "w") do |file|
      all_orders.each do |order|
        file << [order.id, products_to_string(order.products), order.customer.id, order.fulfillment_status.to_s]
      end
    end
  end
  
  #
  def self.products_to_string(products_hash)
    products_string = ""
    
    products_hash.each_with_index do |(name, cost), index|
      products_string << "#{name}:#{cost}"
      products_string << ";" unless (index + 1) == products_hash.length
    end
    
    return products_string
  end
end