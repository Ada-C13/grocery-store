require "awesome_print"
require "csv"
require_relative "customer"

class Order
  attr_reader :id
  attr_accessor :products, :fulfillment_status, :customer

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id #integer
    @products = products #hash
    @customer = customer #instance of customer
    @fulfillment_status = fulfillment_status
    unless @fulfillment_status == :pending || @fulfillment_status == :paid || @fulfillment_status == :processing || @fulfillment_status == :shipped || @fulfillment_status == :complete
      raise ArgumentError, "The status is invalid"
    end
  end

  def self.all
    orders_collection = []
    CSV.read("data/orders.csv").each do |order|
      list_of_products = []
      products_array = []  
      order[1].split(';').each do |product_and_price|
        products_array = product_and_price.split(':')
        list_of_products << products_array
      end
      @products = list_of_products.reduce({}) do |hash, pair_array|
        hash[pair_array[0]] = pair_array[1].to_f
        hash
      end
      order_object = Order.new(order[0].to_i, @products, Customer.find(order[2].to_i), order[3].to_sym)
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
    price = 0
    @products.each do |product, cost|
      price += cost
    end
      price *= 1.075
    return price.round(2)
  end

  def add_product(product_name, price)
    if @products.keys.include? product_name
      raise ArgumentError, "Such product already exists in the list"
    else
      @products[product_name] = price
    end
    return @products
  end

  def remove(product_name)
    unless @products.keys.include? product_name
      raise ArgumentError, "There is no such product in the list"
    else
      @products.delete(product_name)
    end
    return @products
  end
end
