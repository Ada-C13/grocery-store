require_relative 'order.rb'

class Order
    attr_reader :id, :products,

def initialize(id,products,customer,fufillment_status = pending)
    @id = id 
    @products = products
    @customer = customer
    @fufillment_status = fufillment_status
end 

def total
price * .075%
Rounding the result to two decimal places
end

def add_product(products_name,price)
    products = {}
    
end
def fufillment_status
    raise ArgumentError if fufillment_status 
end 
end