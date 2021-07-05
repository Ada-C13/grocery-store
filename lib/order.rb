require_relative 'customer'
class Order 
  attr_reader :id 
  attr_accessor :products, :customer, :fulfillment_status
  FULFILLMENT_VALID_STATUS = [:paid, :processing, :shipped, :complete, :pending].freeze
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id 
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    raise ArgumentError if !FULFILLMENT_VALID_STATUS.include?(fulfillment_status)
  end 
  
  def total
    tax = 0.075
    sum_values = products.values.sum 
    total_price = sum_values + (sum_values * tax)
    return total_price.round(2)
  end 
  
  def add_product(name, price)
    raise ArgumentError if products.key?(name)
    products[name] = price.to_f.round(2)
  end
  
  def self.all
    orders_info = []
    CSV.read('./data/orders.csv').each do |order|
      current_order = Order.new(order[0].to_i, {}, Customer.find(order[2].to_i), order[3].to_sym)
      purchases = order[1].split(';')
      purchases.each do |purchase|
        name_price = purchase.split(':')
        current_order.add_product(name_price[0], name_price[1])
      end
      orders_info << current_order
    end 
    return orders_info
  end 
  
  def self.find(purchase_id)
    id_find = all.find do |purchase|
      purchase_id == purchase.id  
    end 
    return id_find
  end 
  
end 