require_relative "customer"
require "pry"

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status
  
  # (num, hash, instance of customer, symbol)
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    status_lists = [:pending, :paid, :processing, :shipped, :complete]
    # If a status is given that is not one of the above, an ArgumentError should be raised
    raise ArgumentError.new ("There's no such status!") if !status_lists.any? (fulfillment_status)
    return 0 if @products.empty?
  end

  def total # hash
    if @products.empty?
      return 0
    else
    total_cost = (@products.values.inject{ |sum, price| sum + price} * 1.075).round(2) 
    # Adding a 7.5% tax and round it to two deciamal places
    return total_cost
    end
  end

  def add_product(name, price) # (string, num)
    if products.keys.any? (name)
      raise ArgumentError.new ("There's a duplicate!")  
    else 
      @products[name] = price
    end
  end

  # <Order:0x00007fac2e023af0 @id=1, @products={"apple"=>1.5, "banana"=>3.0}, @customer=#<Customer:0x00007fac2e023c58 @id=123, @email="amy@ada.com", @address={:street=>"123 Main", :city=>"Seattle", :state=>"WA", :zip=>"98101"}>, @fulfillment_status=:pending>

  # ["98", "Cumquat:3.14;Peppers:65.33", "26", "processing"]
  def self.all
    # return a collection of order from the csv
    orders = CSV.read("./data/orders.csv")
    orders_lists = []
    orders.each do |line|
      id = line[0].to_i
      products = line[1].split(";").map{|item| item.split(":")}.map{|key, value| [key, value.to_f] }.to_h
      id_num = line[2].to_i
      customer = Customer.find(id_num)
      fulfillment_status = line[3].to_sym
      
      orders_lists << Order.new(id, products, customer, fulfillment_status)
    end
    return orders_lists
  end

  def self.find(id) #num
    orders = Order.all
    orders.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end

end

p a = Order.find(25)

# amy = Customer.new(123, "amy@ada.com", {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# })
# # p amy

# p a = Order.new(1, {"apple" => 1.5, "banana" => 3.0}, amy)

# p a.add_product("apple", 1.3)

# p Order.all




# raise ArgumentError.new ("There's no such status") if fulfillment_status != :pending && fulfillment_status != :paid && fulfillment_status != :processing && fulfillment_status != :shipped && fulfillment_status != :complete