require_relative 'order.rb'

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
   return  raise ArgumentError
  else @products[product_name] =
   product_price 
  return true
  end
end

def fufillment_status(fulfillment_status)
     valid_statuses = %w[pending paid processing shipped complete]
     bogus_statuses = [3, :bogus, 'pending', nil]
    #  if 
    # if fufillment_status != :pending||:paid ||:processing ||:shipped||:complete
    # raise ArgumentError
    # end
end 
end