require_relative 'order.rb'

class Order
    attr_reader :id
    attr_accessor :products,:customer,:fufillment_status


def initialize(id,products,customer,fufillment_status = :pending)
    @id = id 
    @products = products
    @customer = customer
    @fufillment_status = fufillment_status
end 

def total
price * 0.075
end

def add_product(product_name,product_price)
  if products.has_key?product_name
   return false
  else @products[product_name] =
   product_price 
  return true
end
end

def fufillment_status(fufillment_status)
    raise ArgumentError if fufillment_status != :pending||:paid ||:processing ||:shipped||:complete
end 
end