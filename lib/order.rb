require 'csv'
require_relative 'customer'

class Order
  attr_reader :id, :products, :customer, :fulfillment_status
  attr_writer :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    case fulfillment_status 
    when :pending, :paid, :processing, :shipped, :complete
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end 

  def total
    total_value = @products.values.sum
    total_value_tax = (total_value * 1.075)
    total_value_tax = total_value_tax.round(2)
    return total_value_tax
  end


  def add_product(name, price)
    if @products.key?(name)
      raise ArgumentError
    else
      @products[name] = price
      return @products
    end  
  end

  def self.all
    orders = []
    CSV.read('./data/orders.csv').each do |order|
      id = order[0].to_i
      products = {}
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym

      spleted_name = order[1].split(";")
      spleted_name.each do |sname|
        second_split = sname.split(":")
        products[second_split[0]] = second_split[1].to_f
      end
      orders << Order.new(id, products, customer, fulfillment_status)
    end
    return orders
  end

  def self.find(id)
    Order.all.each do |custumer|
      if custumer.id  == id
        return custumer
      end
    end
    return nil
  end
  
end
