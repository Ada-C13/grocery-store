require_relative 'customer'
require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    if [:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
      @fulfillment_status = fulfillment_status
    else 
      raise ArgumentError.new("That is not a valid fulfillment status.")
    end
  end

  def total
    sum = products.values.sum
    tax = sum * 0.075
    sum += tax
    return sum.round(2)
  end

  def add_product(name, price)
    if @products.keys.include? name
      raise ArgumentError.new("That product is already in the order.")
    end
    @products[name] = price
  end

  def remove_product(name)
    if !(@products.keys.include? name)
      raise ArgumentError.new("That product is not in the order.")
    end
    @products.delete(name)
  end

  def self.get_products(string)
    products = {}
    string.split(";").each do |product|
      name_price = product.split(":")
      products[name_price[0]] = name_price[1].to_f
    end
    return products
  end

  def self.all
    all_orders = []
    orders = CSV.read('data/orders.csv')
    orders.each do |order|
      products = get_products(order[1])
      all_orders << Order.new(order[0].to_i, products, Customer.find(order[2].to_i), order[3].to_sym)
    end
    return all_orders
  end

  def self.find(id)
    if id <= 0
      return nil
    end
    return Order.all[id-1]
  end

end