#!/usr/bin/ruby
# 
# Title  : Order - Ada Cohort 13 - Space
# Author : Suely Barreto
# Date   : February 2020
# 

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid = %i[pending paid processing shipped complete]

    unless valid.include?(@fulfillment_status)
      raise ArgumentError, "Invalid Status"
    end
  end

  def total
    sum   = @products.values.sum
    tax   = sum * 0.075
    total = (sum + tax).round(2)
    return total
  end

  def add_product(name, price)
    if @products.include?(name)
      raise ArgumentError, "Product already in this order"
    end
    @products[name] = price
  end

  def remove_product(name)
    unless @products.include?(name)
      raise ArgumentError, "Product not in this order"
    end
    @products.delete(name)
  end

  def self.products_str_to_hash(products_str)
    products_arr  = products_str.split(";")
    products_hash = {}
    products_arr.each do |item|
      item_info = item.split(":") 
      products_hash[item_info[0]] = item_info[1].to_f
    end

    return products_hash
  end


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

  def self.find(id)
    return Order.all.select { |o| o.id == id }.first
  end

  def self.find_by_customer(customer_id)
    return Order.all.select { |o| o.customer.id == customer_id }
  end

end

