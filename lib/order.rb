# test = { "banana" => 1.99, "cracker" => 3.00 }
# puts sum(test)

class Order
  attr_reader :id
  attr_accessor :products, :fulfillment_status, :customer

  

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    options = [:pending, :paid, :processing, :shipped, :complete]

    unless options.include? fulfillment_status
      raise ArgumentError.new("#{fulfillment_status} is not a valid option, please try again.")
    end

  end

  def total
    to_sum = []
    products.each do |product, price|
      to_sum << price
    end
    first_total = to_sum.sum
    total = (first_total * 1.075).round(2)
    return total
  end

  def add_product(product_name, price)
    if @products.include? product_name
      raise ArgumentError.new("#{product_name} is already included in the product list.")
    else
      @products[product_name] = price
    end
  end
end

