require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status 

  def initialize(id,products,customer,fulfillment_status = :pending)
    raise ArgumentError if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status) == false
  
    @id = id # a number 
    @products = products # a hash, where keys are product names and values are price
    @customer = customer # instance of Customer
    @fulfillment_status = fulfillment_status # a symbol, either :pending, :paid, :processing, :shipped, or :complete
  end

  # instance method which returns the sum (a float) of the items in the order 
  def total
    sum_of_products = @products.map { |item, price| price }.sum 
    sum_with_tax = sum_of_products * 1.075
    return sum_with_tax.round(2)
  end

  # instance method which adds a product with price information to the @products hash. Returns the hash of products
  def add_product(product_name,price)
    raise ArgumentError if @products.keys.include?(product_name)
    @products[product_name] = price
    return @products
  end

  # class method which reads the CSV file of orders and returns a collection of those Order instances
  def self.all
    collection_of_orders = []
    CSV.read("data/orders.csv").map(&:to_a).each do |order|
      id = order[0].to_i
      products_hash = {}
      order[1].split(";").each do |food_info|
        food_name = food_info.split(":")[0]
        food_price = food_info.split(":")[1].to_f
        products_hash[food_name] = food_price
      end
      customer_instance = Customer.find(order[2].to_i)
      full_status = order[3].to_sym
      collection_of_orders.push(Order.new(id,products_hash,customer_instance,full_status))
    end
    return collection_of_orders
  end

  # class method which searches for and returns an order from data in the CSV file based on the order ID input
  def self.find(id)
    return self.all.find { |order| order.id == id }
  end

end