require "csv"
require_relative "customer.rb"

class Order
  attr_reader :id
  attr_accessor :products, :fulfillment_status, :customer

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError.new unless [:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
    
    @id = id
    @customer = customer
    @products = products
    @fulfillment_status = fulfillment_status
  end

  def total
    return 0 if products == {}
    total = products.values.reduce(:+)
    tax = total * 0.075
    total = total + tax
    return total.round(2)
  end

  def add_product(name, price)
    raise ArgumentError.new if products.keys.include? name
    @products[name] = price 
    return @products 
  end

  def self.all
    data = CSV.read("./data/orders.csv")
    order_info = []

    data.each do |row|
      id = row[0].to_i
      customer = Customer.find(row[2].to_i)
      fulfillment_status = get_fulfillment_status(row[3])
      products = get_products(row[1])

      order = Order.new(id, products, customer, fulfillment_status)
      order_info << order
    end
    return order_info
  end

  def self.find(id)
    order_info = self.all
    order_with_id = order_info.find { |order| order.id == id}
    return order_with_id
  end
end

# HELPER METHODS
def get_fulfillment_status(string_status)
  status_data = {
    "pending" => :pending,
    "paid" => :paid,
    "processing" => :processing,
    "shipped" => :shipped,
    "complete" => :complete
  }
  fulfillment_status = status_data[string_status]
  return fulfillment_status
end

def get_products(products_data)
  products = {}
  products_data.split(";").each do |product_price_pair|
    product_price_pair_array = product_price_pair.split(":")
    products[product_price_pair_array[0]] = product_price_pair_array[1].to_f
  end 
  return products
end