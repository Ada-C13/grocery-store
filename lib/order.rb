require_relative "customer"

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status
  
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

  def total
    if @products.empty?
      return 0
    else
      # Adding a 7.5% tax and round it to two deciamal places
      total_cost = (@products.values.inject{ |sum, price| sum + price} * 1.075).round(2)
    return total_cost
    end
  end

  def add_product(name, price)
    if products.keys.any? (name)
      raise ArgumentError.new ("There's a duplicate!")  
    else 
      @products[name] = price
    end
  end

  def self.all
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

  def self.find(id)
    orders = Order.all
    orders.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end
end
