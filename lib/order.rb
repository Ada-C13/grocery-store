class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid_statuses = %i[pending paid processing shipped complete]

    if valid_statuses.include?(@fulfillment_status)
      return true
    else
      raise ArgumentError.new("That's not a valid status.")
      return false
    end
  end

  # A collection of products and their cost. This data will be given as a hash that looks like this:
  # { "banana" => 1.99, "cracker" => 3.00 }
  # Zero products is permitted (an empty hash)
  # You can assume that there is only one of each product
  # An instance of Customer, the person who placed this order
  # A fulfillment_status, a symbol, one of :pending, :paid, :processing, :shipped, or :complete
  # If no fulfillment_status is provided, it will default to :pending
  # If a status is given that is not one of the above, an ArgumentError should be raised

  def total
    cost = 0
    @products.map do |key, value|
      cost += value
    end

    tax = 0.075
    total = cost * (1 + tax)
    return total.round(2)

    # calculate the total cost of the order by:
    # Summing up the products
    # Adding a 7.5% tax
    # Rounding the result to two decimal places
  end

  def add_product(name, price)
    # An add_product method which will take in two parameters, product name and price, and add the data to the product collection
    # If a product with the same name has already been added to the order, an ArgumentError should be raised

    raise ArgumentError.new("That product already exists.") if @products.key?(name)
    @products[name] = price
  end
end

# ! Optional
# def remove_product(name)
#   # Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
#   # If no product with that name was found, an ArgumentError should be raised
# end
