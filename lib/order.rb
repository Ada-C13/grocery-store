require_relative 'customer'
require 'csv'
class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    # Takes care of fulfillment status
    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]

    unless valid_statuses.include?(fulfillment_status)
      raise ArgumentError.new("Not a valid statement")
    end
    
  end

  # Method to define total of product
  def total
    total = 0
    @products.each_value do |value|
        total += value
    end

    total = total.to_f
    total = (total * 0.075) + total

    return 0 if products == {}
    return total.round(2)
    
  end

  # method to add product
  def add_product (product_name, price)
     # raise error if duplicate is contained for adding product
    if products.include?(product_name)
      raise ArgumentError.new("Item is included")
    else
      products["#{product_name}"] = price
    end
  end

  # Wave 2

  # Helper method for turning orders CSV of products
  # from "name:price;nextname:nextprice" to hash
  def self.orders_csv_product(product_string)
    product_hash = Hash[*product_string.split(/[:;]/)]
    product_hash = product_hash.each {|product_name, price| product_hash[product_name] = price.to_f}
    return product_hash
  end

  # Method for that returns a collection of Order instances
  def self.all
    orders_csv = CSV.read("./data/orders.csv")

    orders = orders_csv.map do |order_row|
      Order.new(order_row[0],
        orders_csv_product((order_row[1])), Customer.find((order_row[2]).to_i), (order_row[3]).to_sym)
    end

    return orders
  end

  # Method that returns Order
  # when id given is found in CSV 
  def self.find(id)
    orders = Order.all
    found_order = orders.detect {|order| (order.id) == id}
    return found_order
  end

end