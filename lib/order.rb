
require 'csv'
require_relative "customer"

class Order

  attr_reader :id, :customer, :fulfillment_status
  attr_accessor :products

    def initialize(id, products  , customer, fulfillment_status = :pending)
    #def initialize(id, products = {}, customer, fulfillment_status = :pending) <-- doesn't work 

      @id = id
      @products= products 
      @customer=customer
      @fulfillment_status = fulfillment_status #A fulfillment_status, a symbol, one of :pending, :paid, :processing, :shipped, or :complete
      unless  (fulfillment_status == :pending || fulfillment_status == :paid || fulfillment_status == :processing || fulfillment_status == :shipped || fulfillment_status == :complete)
        raise ArgumentError
      end
    end

#     A total method which will calculate the total cost of the order by:
# Summing up the products
# Adding a 7.5% tax
# Rounding the result to two decimal places
    
    def total
      if @products == {}
        return 0 
      else
        m = 0
        @products.values.each do |v|
          m += v
        end

        sum = (m + (m * 0.075)).round(2)
        return sum
      end
    end

    def add_product(product_name,price)
      if products.keys.include? product_name
        raise ArgumentError
      else
      products[product_name] = price
      end


    end

    def self.all
      orders_list = []
      CSV.foreach("data/orders.csv") do |order|
        #CSV.foreach("path/to/file.csv", **options) do |row|
        id = order[0].to_i
        products = {}
        product = order[1].to_s
        product.split(';').each do |pair|
          key,value = pair.split(/:/) 
          products[key.to_s] = value.to_f
        end
        #puts products
        customer_id = order[2].to_i
        customer = Customer.find(customer_id)
        fulfillment_status = order[3].to_sym
        #puts id, products, customer, fulfillment_status
        orders_list.push Order.new(id,products,customer,fulfillment_status)
      end
      return orders_list
    end
    
    def self.find(x)
      list = Order.all
      list.each do |order|
        if order.id == x 
          return order
        end
      end 
      return nil 
    end

    # self.all - returns a collection of Order instances, representing all of the Orders described in the CSV file
    # self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter


end
