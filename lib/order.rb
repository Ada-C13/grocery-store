# require_relative 'customer'


class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status # come back to this and make sure it's correct

  def initialize(id,products,customer,fulfillment_status = :pending)
    raise ArgumentError if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status) == false
    @id = id # a number 
    @products = products # a hash, where keys are product names and values are price
    @customer = customer # instance of Customer
    @fulfillment_status = fulfillment_status # a symbol, one of :pending, :paid, :processing, :shipped, or :complete
  end

  def total
    sum_of_products = @products.map { |item, price| price }.sum 
    sum_with_tax = sum_of_products * 1.075
    return sum_with_tax.round(2)
  end

  def add_product(product_name,price)
    raise ArgumentError if @products.keys.include?(product_name)
    @products[product_name] = price
    return @products
  end

end