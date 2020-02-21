require_relative 'customer.rb'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    case fulfillment_status
    when :pending, :paid , :processing , :shipped, :complete
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end
    
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    sum_of_products = products.values.sum.to_f
    plus_sales_tax = 1.075
    total_cost = (sum_of_products * plus_sales_tax)
    total_cost = total_cost.round(2)
    return total_cost
  end

  def add_product(product_name, price)
    product_name = product_name.to_s
    price = price.to_f.round(2)

    raise ArgumentError if @products.keys.include?(product_name)
    @products[product_name] = price
    return @products
  end

end