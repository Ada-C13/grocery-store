require_relative "customer"

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
    prices = products.values.sum
    grand_total = (prices * (1+tax)).round(2)
    return grand_total
  end

  def add_product(name, price)
    raise ArgumentError if products.key?(name)
    products[name] = price
  end

  def remove_product(name)
    raise ArgumentError if !products.key?(name)
    products.delete(name)
  end

  def self.all
    all_orders = []
    csv_orders = CSV.read("./data/orders.csv")
    csv_orders.each do |order|
      id_read = order[0].to_i
      fulfillment_status_read = order[3].to_sym
      cust_id = order[2].to_i
      customer_read = Customer.find(cust_id)
      products_read = {}

      all_products = order[1]
      split_products = all_products.split(";")
      split_products.each do |string|
        strings_array = string.split(":")
        name = strings_array[0]
        price = strings_array[1].to_f
        products_read[name] = price
      end
      each_order = Order.new(id_read, products_read, customer_read,fulfillment_status_read)
      all_orders << each_order
    end

    return all_orders
  end

  def self.find(id)
    self.all.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end

  def Order.find_by_customer(customer_id)
    orders_per_customer = []
    customer_instance = Customer.find(customer_id)
    self.all.each do |order|
      if order.customer == customer_instance
        orders_per_customer << order
      end
    end
    return orders_per_customer
  end
end
