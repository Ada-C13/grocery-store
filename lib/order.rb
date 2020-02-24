require 'csv'

class Order

  orders = CSV.read('data/orders.csv', headers: true).map(&:to_h)

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_states = [:pending, :paid, :processing, :shipped, :complete]
    @id = id
    @products = products 
    @customer = customer
    @fulfillment_status = fulfillment_status
    raise ArgumentError unless valid_states.include?(fulfillment_status)
  end 

  def total
    order_total = 0
    @products.each do |name, price|
      order_total += price 
    end 
    order_total = order_total * 1.075
    order_total = order_total.round(2)
  end 

  def add_product(name, price)
    if @products.include? name
      raise ArgumentError.new("That item is already in your cart.")
    else
      @products.store(name, price)
    end
  end 

  def self.all
    csv_orders = CSV.read('data/orders.csv')
    orders = []
    csv_orders.each do |row|
      order_id = row[0].to_i
      temp_products = row[1].split(";") 
      products = {}

      temp_products.each do |product|
        product = product.split(":")
        name = product[0]
        price = product[1]
        products.store(name, price.to_f)
      end 

      customer_id = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym

      orders.push(Order.new(order_id, products, customer_id, fulfillment_status))
    end 
    return orders
  end

  
  def self.find(id)
    Order.all.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end
end