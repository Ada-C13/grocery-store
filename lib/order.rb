require_relative 'customer'
class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    # takes care of fulfillment status
    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]

    unless valid_statuses.include?(fulfillment_status)
      raise ArgumentError.new("Not a valid statement")
    end
    
  end

  # method to define total of product
  def total
    total = 0
    @products.each_value do |value|
        total += value
    end

    total = total.to_f
    total = (total * 0.075) + total

    return 0 if products == {}
    return total.round(2)
    
  end

  # method to add product
  def add_product (product_name, price)
     # raise error if duplicate is contained for adding product
    if products.include?(product_name)
      raise ArgumentError.new("Item is included")
    else
      products["#{product_name}"] = price
    end
  end

 

end