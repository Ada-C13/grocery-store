require 'awesome_print'
require 'csv'
require_relative 'customer'

#Create a class called Order
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses =  [:pending, :paid, :processing, :shipped,:complete]
    unless valid_statuses.include?(fulfillment_status)
    raise ArgumentError, 'you have provided an invalied choice'
    end 
  end

  # Create a total method
  def total
   all_costs = products.map do |product, cost|
      cost
   end 
   sum_costs = all_costs.sum
   total = (sum_costs + sum_costs * 0.075).round(2)
   return total
  end


# Create add_product method 
  def add_product(product_name, price)
    # get all the names of product from products hash
    raise ArgumentError if products.key?(product_name)
    @products[product_name] = price
    return @products
  end

  # def product_to_hash(string)
  #   splitted_string = string.split(';')
  #   splitted_string.map! do |element|
  #     element.split(':')
  #   end
  #   # create a hash of name and price
  #   product_hash = {}
  #   splitted_string.each do|product|
  #     product_hash[product[0]] = product[1].to_f
  #   end
  #   return product_hash
  # end

  def self.all
      orders = []
      CSV.read('./data/orders.csv').each do |order|
        id = order[0].to_i
        products = {}
        first_time_splitted_string = order[1].split(";")
        first_time_splitted_string.each do |element|
          second_time_splitted_string = element.split(":")
          products[second_time_splitted_string[0]] = second_time_splitted_string[1].to_f
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
      return nil
    end 
  end

end

  

  

