require_relative 'customer'
require 'csv'

class Order
  
  attr_reader :id 
  attr_accessor :products, :customer, :fulfillment_status
  
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
   
    case fulfillment_status 
      when :pending, :paid, :processing, :shipped, :complete
        @fulfillment_status = fulfillment_status
      else raise ArgumentError 
    end
  end
  
  def total
    if @products == {}
      return 0
    else
      total = @products.values.sum
      total = total * 1.075
      return total.round(2)
    end
  end
  
  def add_product(product, price)
    if @products.key?(product)
      raise ArgumentError
    else
      @products[product] = price
    end
  end

  def self.parse_products(product_string)
    products_array = product_string.split(/[;:]/)
    products = {}
    i=0
    (products_array.length/2).times do 
      products[products_array[i]] = products_array[i+1].to_f
      i += 2
    end
    return products
  end

  def self.all
    order_csv = CSV.read("./data/orders.csv")
    orders = order_csv.map do |order_row|
      products = Order.parse_products(order_row[1])
      Order.new(order_row[0], 
        products, 
        Customer.find(order_row[2].to_i), 
        order_row[3].to_sym)  
      end
  return orders
  end 

  def self.find(id)
    return (self.all).bsearch { |order| id <=> order.id}
  end

end

