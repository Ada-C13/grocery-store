require_relative "customer.rb"
require "csv"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    valid_statuses = %i[pending paid processing shipped complete]
    raise(ArgumentError, "Not a valid status") unless valid_statuses.include? fulfillment_status
    @fulfillment_status = fulfillment_status
  end

  #add total method to calculate the total
  def total
    return 0 if @products.empty?

    total = @products.values.sum
    total += (total * 0.075)
    return total.round(2)
  end

  #add add_product to add product to @product
  def add_product(product_name, product_price)
    raise(ArgumentError, "Item already exits") if @products.include? product_name
    @products.store(product_name, product_price)
  end

  #add remove_product to remove a product from @product
  def remove_product(product_name)
    raise(ArgumentError, "Item does not exist") unless @products.include? product_name
    @products.delete(product_name)
  end

  #make a method to split string and turn to hash
  def self.string_to_hash(name)
    items_hash = {}
    item_and_price = name.split(";")
    item_and_price.each do |item_price|
      item_and_price_split = item_price.split(":")
      items_hash[item_and_price_split[0]] = item_and_price_split[1].to_f.round(2)
    end
    return items_hash
  end

  #return an instance of all placed orders
  def self.all
    data = CSV.read("data/orders.csv")

    orders = data.map do |order|
      order_id = order[0].to_i
      products = string_to_hash(order[1])
      customer_id = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym

      Order.new(order_id, products, customer_id, fulfillment_status)
    end
    return orders
  end

  #   return an instance of order using order id
  def self.find(id)
    all_orders = Order.all
    return all_orders.find do |order|
             id == order.id
           end
  end

  #returns instance(s) of all order placed using customer id
  def self.find_by_customer(customer_id)
    all_orders = Order.all

    return all_orders.find_all do |order|
             customer_id == order.customer.id
           end
  end
end
