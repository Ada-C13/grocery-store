require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError unless %i[pending paid processing shipped complete].include?(fulfillment_status)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def self.products_to_h(products_input)
    products_input = products_input.split(";")
    products = {}
    products_input.each do |product|
      product = product.split(":")
      products[product[0]] = product[1].to_f
    end
    return products
  end

  def self.all
    all_orders = []
    CSV.read('data/orders.csv').each do |order|
      id = order[0].to_i
      products = Order.products_to_h(order[1])
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym
      all_orders << Order.new(id, products, customer, fulfillment_status)
    end
    return all_orders
  end

  def self.find(id)
    Order.all.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end

  #Order.find_by_customer(customer_id) - returns a list of Order instances where the value of the customer's ID matches the passed parameter
  def self.find_by_customer(customer_id)
    all_customer_orders = []
    Order.all.each do |order|
      if order.customer.id == customer_id
        all_customer_orders << order
      end
    end
    return all_customer_orders
  end
  
  def total
   total = 0
    @products.each do |key, value|
      total += value
    end
    total += total * 0.075
    total = ('%.2f' % total).to_f
    return total
  end

  def add_product(name, price)
      raise ArgumentError if @products.has_key?(name)
      products[name] = price
  end

end