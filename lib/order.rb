require 'csv'
require_relative 'customer'

# Add constants 
STATUSES = [:pending, :paid, :processing, :shipped, :complete]

class Order 

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)

    # If status is not valid, raise an error
    if !STATUSES.include?(fulfillment_status)
      raise ArgumentError.new("#{fulfillment_status} is not valid. Please enter a valid status.")
    end 

    @id = id
    @products = products
    @customer = customer  # an instance of customer
    @fulfillment_status = fulfillment_status
  end 


  def total
    sum = @products.values.sum

    return 0 if sum == 0 

    tax = sum * 0.075  # 7.5%
    total_price = sum + tax

    return total_price.round(2)
  end 


  def add_product(product_name, price) 
    if @products[product_name]
      raise ArgumentError.new("The product, #{product_name} has already added to the order.")
    else 
      @products[product_name] = price
    end 
  end 


  def remove_product(product_name) 
    if @products[product_name]
      @products.delete(product_name)
    else 
      raise ArgumentError.new("The product, #{product_name} was not found in the order system.")
    end 
  end 


  def self.all 
    order_instances = CSV.read("data/orders.csv").map do |order_data|

      id = order_data[0].to_i 
     
      products_data = order_data[1].split(";")  # i.e. ["Miso:88.86", "White Wine:8.52", "Turnips:30.73"]


      products = products_data.map do |product_data| # i.e. "Miso:88.86"
        
        # Reassign the product_data 
        product_data = product_data.split(":")  # i.e. ["Miso", "88.86"]
      
        [product_data[0], product_data[1].to_f] # [key, value]
      end.to_h 

      
      customer_id = order_data[2].to_i 
      fulfillment_status = order_data[3].to_sym
      customer_instance = Customer.find(customer_id)

      Order.new(id, products, customer_instance, fulfillment_status)
    end 

    return order_instances
  end 


  def self.find(id)
    order_instances = self.all

    found_order_instance = order_instances.find do |order_instance| 
      order_instance.id == id 
    end 

    # Return an instance of Order
    return found_order_instance
  end 


  # Wave 2 - Optional
  def self.find_by_customer(customer_id)
    order_instances = self.all 

    order_instances_by_customer_id = order_instances.filter do |order_instance| 
      order_instance.customer.id == customer_id
    end 

    return nil if order_instances_by_customer_id.empty?

    # Return a "list" of Order instances
    return order_instances_by_customer_id
  end 
end 