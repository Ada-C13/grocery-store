require "csv"
require_relative "customer"

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
  end

  def add_product(name, price)
    raise ArgumentError.new("That product already exists.") if @products.key?(name)
    @products[name] = price
  end

  def self.all
    # returns a collection of Order instances, representing all of the Orders described in the CSV file
    orders = []

    CSV.read("data/orders.csv").each do |order|
      products = {}
      id = order[0].to_i
      split_1 = order[1].split(";")
      split_1.each do |string|
        split_2 = string.split(":")
        products[split_2[0]] = split_2[1].to_f
      end
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym

      orders << Order.new(id, products, customer, fulfillment_status)
    end
    return orders
  end

  def self.find(id)
    Order.all.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end
end

# ! Optional
# def remove_product(name)
#   # Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
#   # If no product with that name was found, an ArgumentError should be raised
# end
