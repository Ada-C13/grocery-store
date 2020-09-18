#!/usr/bin/ruby
# 
# Title  : Order - Ada Cohort 13 - Space
# Author : Suely Barreto
# Date   : February 2020
# 

# Create a Class Order
class Order

  # Generator
  attr_reader   :id
  attr_accessor :products, :customer, :fulfillment_status

  # Constructor
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    valid = %i[pending paid processing shipped complete]
    unless valid.include?(fulfillment_status)
      raise ArgumentError, "Invalid Status"
    end
    @fulfillment_status = fulfillment_status
  end

  # Instance Method to Calculate Total Cost of the Order, with 7.5% Tax
  def total
    sum   = @products.values.sum
    tax   = sum * 0.075
    total = (sum + tax)
    return total
  end
 
  # Instance Method to Add a Product
  def add_product(name, price)
    if @products.include?(name)
      raise ArgumentError, "Product already in this order"
    end
    @products[name] = price
  end

  # Instance Method to Remove a Product
  def remove_product(name)
    unless @products.include?(name)
      raise ArgumentError, "Product not in this order"
    end
    @products.delete(name)
  end

  # Class Method to Parse the Product String in the CSV File
  # Ex:"Amaranth:83.81;Smoked Trout:70.6;Cheddar:5.63"
  def self.products_str_to_hash(products_str)
    products_arr  = products_str.split(";")
    products_hash = {}
    products_arr.each do |item|
      item_info = item.split(":") 
      products_hash[item_info[0]] = item_info[1].to_f
    end
    return products_hash
  end

  # Class Method to Read from a CSV File and Return an Array of Orders
  def self.all
    filename   = "data/orders.csv"
    csv_all    = CSV.read(filename)

    all_orders = []
    csv_all.each do |csv_row|
      order_id = csv_row[0].to_i
      products = Order.products_str_to_hash(csv_row[1])
      customer = Customer.find(csv_row[2].to_i)
      fulfillment_status = csv_row[3].to_sym

      order = Order.new(order_id, products, customer, fulfillment_status)
      all_orders << order
    end
    return all_orders
  end

  # Class Method to Find an Order by the Order ID
  def self.find(id)
    return Order.all.select { |o| o.id == id }.first
  end

  # Class Method to Find All Orders for a Given Customer
  def self.find_by_customer(customer_id)
    return Order.all.select { |o| o.customer.id == customer_id }
  end

end

