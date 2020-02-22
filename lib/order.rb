require "csv"
require_relative "customer"

# class definition for Order
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  
  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    raise ArgumentError, "Invalid fulfillment status given." if (valid_status.include?(fulfillment_status) == false)
    @fulfillment_status = fulfillment_status
    @id = id
    @products = products
    @customer = customer
  end

  # calculates total cost of the order plus tax
  def total
    tax = 0.075
    prices = products.values.sum
    grand_total = (prices * (1+tax)).round(2)
    return grand_total
  end

  # adds new product to the order
  def add_product(name, price)
    raise ArgumentError, "This product already exists." if products.key?(name)
    products[name] = price
  end

  # removes existing product from the order
  def remove_product(name)
    raise ArgumentError, "Product is not found in this order." if !products.key?(name)
    products.delete(name)
  end

  # Class Method: returns an array of all the order instances from the CSV file. loads the data when called
  def self.all
    all_orders = []
    csv_orders = CSV.read("./data/orders.csv")
    csv_orders.each do |order|
      id = order[0].to_i
      fulfillment_status = order[3].to_sym
      customer_instance = Customer.find(order[2].to_i)
      products = {}

      all_products = order[1].split(";")
      all_products.each do |pair|
        pairs_array = pair.split(":")
        name = pairs_array[0]
        price = pairs_array[1].to_f
        products[name] = price
      end
      all_orders << Order.new(id, products, customer_instance,fulfillment_status)
    end

    return all_orders
  end

  # Class Method: finds order instance by order id
  def self.find(id)
    self.all.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end

  # Class Method: find all orders from a customer with customer id
  def self.find_by_customer(customer_id)
    orders_per_customer = []
    self.all.each do |order|
      if order.customer.id == customer_id
        orders_per_customer << order
      end
    end
    return orders_per_customer
  end
end
