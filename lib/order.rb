class Order
  # id is only reader
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    status = [:pending, :paid, :processing, :shipped, :complete]

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    # if a status is given that is not one of the above, an ArgumentError should be raised
    unless status.include?(@fulfillment_status)
      return raise ArgumentError, "Invalid value."
    end

  # add a total method

  def total
    total = 0
    tax = 1.075
    @products.each do |product, price|
      total += price
    end
    order_total = (total * tax).round(2)
    return order_total
  end

  ###########
# add add_product method
  def add_product(product_name, price)
    if @products.key?(product_name)
        raise ArgumentError.new "Added product already exists"
    else
        @products[product_name] = price
    end
    return @products
end
# add remove_product
def remove_product(product_name)
    if @products.key?(product_name)
       @products.delete(product_name)
    else
        raise ArgumentError.new "Deleted product doesn't exist"
    end
    return @products
end
end
end