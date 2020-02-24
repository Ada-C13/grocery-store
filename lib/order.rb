require_relative 'customer'
require 'awesome_print'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products #hash { "banana" => 1.99, "cracker" => 3.00 }
    @customer = customer
    @fulfillment_status = fulfillment_status

    # valid_status = [:pending, :paid, :processing, :shipped, :complete]

    if !VALID_STATUS.include?(@fulfillment_status)
      raise ArgumentError, "Invalid Status"
    end
  end

  def total()
    total = 0
    @products.each do |key, value| #iterate through hash
      total += value
    end
    total = (total * 1.075).round(2)
  return total
  end

  #Adds a product to collection called products
  #Inputs:
    # product_name (string) 
    # product_price (float)
  # Returns nothing
  def add_product(product_name, product_price)
    if @products.has_key?(product_name)
      raise ArgumentError, "Adding product that already exists."
    else
      @products[product_name] = product_price
    end
  end

  def remove_product(product_name)
    if @products.has_key?(product_name)
      @products.delete(product_name)
      return true
    else
      raise ArgumentError, "Deleting product not found."
    end
  end

  def self.all()
    orders = CSV.read(__dir__ + "/../data/orders.csv")
    all_orders = []
    # 0                         1                               2         3
    # int, "name: price",   "name: price:"    "name: price:"    int     "string"
    # 1,   Lobster:17.18;Annatto seed:58.38;Camomile:83.21,    25,    complete
    orders.each do |order|
      id = order[0].to_i
      #Temp string variable that equals string of products found at order[1]
      temp_str = order[1]
      #Start splitting products at ; 
      temp_products = temp_str.split(";")
      # ["Lobster:17.18", "Annatto seed:58.38", ..]
      products_hash = {} #initialize hash used within this scope
      # Display each value to the console.
      temp_products.each do |product|
        #"Lobster:17.18" results from first split, now splitting product at :
        temp_product = product.split(":")
        # 0               1
        # ["Lobster", "17.18"]
        #assign           key         and     value
        products_hash[temp_product[0]] = temp_product[1].to_f
      end
      
      customer_id = order[2].to_i
      actual_customer = Customer.find(customer_id) #to find actual customer object using public method .find on class Customer by passing in customer_id
      fulfillment_status = order[3].to_sym #this data from csv is string, need to convert to symbol bc initialized status as symbols :
      temp_order = Order.new(id, products_hash, actual_customer, fulfillment_status)
      all_orders.push(temp_order)
    end
    return all_orders
  end

  # Find a list or Order objects based on customer id
  # inputs
  #  customer_id (int) 
  # returns:  array of Order objects
  def self.find_by_customer(customer_id)
    list_of_orders = []
    # Get all orders
    all_orders = self.all()

    # loop thru the orders
    all_orders.each do |order|
      # check orders with customer_id
      if customer_id == order.customer.id
        # once found, add order to list_of_orders
        list_of_orders.push(order)
      end
    end
    return list_of_orders
  end
end

# test_Order = Order.new(100, { "banana" => 1.99, "cracker" => 3.00 }, "char", :pending)
# puts test_Order.id
# puts test_Order.products
# puts test_Order.customer
# puts test_Order.fulfillment_status
# test_Order.customer = "me"
# puts test_Order.customer

# puts test_Order.total()
# test_Order.add_product("cheese", 5.00)
# puts test_Order.products
# puts test_Order.total
# test_Order.remove_product("cheese")
# puts test_Order.products
# puts Order.all[7].products


# puts Customer.find(25).email
# Order.find_by_customer(25).each do |order|
#   puts order
# end




