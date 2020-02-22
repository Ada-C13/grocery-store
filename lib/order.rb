require_relative "customer"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]
    if !valid_statuses.include? fulfillment_status
      raise ArgumentError.new("Invalid status")
    end
    @fulfillment_status = fulfillment_status
  end

  def total()
    sum = 0
    @products.each do |product, cost|
      sum += cost
    end

    sum_with_tax = (sum + (sum * 0.075)).round(2)

    return sum_with_tax
  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError.new("This product is already in the collection.")
    end

    @products[product_name] = price
  end

  def self.all
    file = "./data/orders.csv"
    orders = []

    CSV.read(file).each do |line|
      id = line[0].to_i
      customer_id = line[2].to_i
      customer = Customer.find(customer_id)
      status = line[3].to_sym

      products_as_array = line[1].split(";")
      products_as_hash = {}
      products_as_array.each do |product|
        prod_name = product.split(":")[0]
        prod_cost = product.split(":")[1]
        products_as_hash[prod_name] = prod_cost.to_f
      end

      current_order = Order.new(id, products_as_hash, customer, status)
      orders << current_order
    end

    return orders
  end


  def self.find(id)
    orders = Order.all
    orders.each do |order_object|
      if order_object.id == id
        return order_object
      end
    end

    return nil
  end
end
