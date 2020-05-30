require 'awesome_print'
require 'csv'
require_relative 'customer'

class Order
  attr_reader :id, :customer, :products
  attr_accessor :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id #integer
    @products = products #hash
    @customer = customer #instance of customer
    status_options = [:pending, :paid, :processing, :shipped, :complete]
    unless status_options.include? fulfillment_status
      raise ArgumentError, "The status is invalid"
    end
    @fulfillment_status = fulfillment_status
  end

  def self.all
    orders_collection = []
    CSV.read("data/orders.csv").each do |order|
      products_per_order = []
      order[1].split(';').each do |product_and_price|
        product_and_price = product_and_price.split(':')
        product_and_price[1] = product_and_price[1].to_f
        products_per_order << product_and_price
      end
      id = order.first.to_i
      @products = products_per_order.to_h
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order.last.to_sym
      order_object = Order.new(id, @products, customer, fulfillment_status)
      orders_collection << order_object
    end
    return orders_collection
  end

  def self.find(id)
    Order.all.find do |order|
      order.id == id
    end
  end

  def total
    price = @products.sum { |product, cost| cost }
    price *= 1.075
    return price.round(2)
  end

  def add_product(product_name, price)
    if @products.keys.include? product_name
      raise ArgumentError, "Such product already exists in the list"
    end
    @products[product_name] = price
    return @products
  end

  def remove(product_name)
    unless @products.keys.include? product_name
      raise ArgumentError, "There is no such product in the list"
    end
    @products.delete(product_name)
    return @products
  end
end
