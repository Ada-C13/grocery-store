# class definition for Order
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError, "This is invalid" if (valid_status.include?(@fulfillment_status) == false)
  end

  def total
    tax = 0.075
    prices = @products.values
    grand_total = (prices.sum * (1+tax)).round(2)
    return grand_total
  end

  def add_product(name, price)
    raise ArgumentError if products.key?(name)
    products[name] = price
  end

end


# A total method which will calculate the total cost of the order by:
# Summing up the products
# Adding a 7.5% tax
# Rounding the result to two decimal places

# products = { "banana" => 1.99, "cracker" => 3.00 }
#       order = Order.new(1337, products, customer)

#       expected_total = 5.36

#       expect(order.total).must_equal expected_total
