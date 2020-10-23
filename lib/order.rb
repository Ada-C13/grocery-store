require 'csv'
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  
  FULFILLMENT_VALID_STATUS = [:paid, :processing, :shipped, :complete, :pending]
  
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    
    raise ArgumentError if !FULFILLMENT_VALID_STATUS.include?(fulfillment_status)
  end
  
  def total
    sum = products.values.sum
    tax = sum * 0.075
    grand_total = sum + tax
    return grand_total.round(2)
  end
  
  def add_product(name, price)
    raise ArgumentError if products.key?(name)
    @products[name] = price
  end
  
  def self.products_hash(orders)
    products = {}
    items = orders.split(";")
    items.each do |item|
      product_info = item.split(":")
      products[product_info[0]] = product_info[1].to_f
    end
    return products
  end
  
  def self.all
    order_info = CSV.read('../data/orders.csv')
    all_orders = order_info.map do |line|
      id = line[0].to_i
      products = Order.products_hash(line[1])
      customer = Customer.find(line[2].to_i)
      fulfillment_status = line[3].to_sym
      Order.new(id, products, customer, fulfillment_status)
    end
    return all_orders
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
