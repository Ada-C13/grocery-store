require_relative 'order.rb'
require 'csv'
require 'awesome_print'

class Order
    attr_reader :id
    attr_accessor :products,:customer,:fulfillment_status



def initialize(id,products,customer,fulfillment_status = :pending)
    @id = id 
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
end 

def total
  sum = 0 
  @products.each do |product_name,product_price|
  sum += product_price 
  end
  sum = (sum + (sum * 0.075).round(2))
  return sum
end

def add_product(product_name,product_price)
  if products.has_key?product_name
  return raise ArgumentError
  else @products[product_name] =
   product_price 
  return true
  end
end

def fufillment_status(fulfillment_status)
    status = [:pending, :paid, :processing, :shipped, :complete]
    if status.include?fulfillment_status == false
    return raise ArgumentError
  end 
end
end