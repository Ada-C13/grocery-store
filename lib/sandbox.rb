require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid_status = [:pending, :paid, :processing, :shipped, :complete]

    if !(valid_status.include?(@fulfillment_status))
      raise(ArgumentError, "Invalid fulfillment status")
    end
  end

  def total
    total = (@products.values.sum) * 1.075
    return total.round(2)
  end

  def add_product(name, price)
    @name = name # this is a key
    @price = price # this is that key's value
    
    if @products.keys.include? name
      raise(ArgumentError, "This product is already included in this order!")
    else @products[name] = price
    end
  end

end

