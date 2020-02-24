require 'csv'
require_relative 'customer'

class Order

  attr_reader :id
  attr_accessor :products, :fulfillment_status, :customer
 
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products
    @fulfillment_status = fulfillment_status
    @customer = customer

    valid_stats = [:pending, :processing, :paid, :shipped, :complete]
    
    unless valid_stats.include? fulfillment_status
      raise ArgumentError.new("The given fulfillment status is invalid, please try again.")
    end

  end

  def total
    if @products == {}
     return 0 
    end

    pre_tax_total = @products.values.sum
    final_total = pre_tax_total * 1.075

    return ('%.2f' % final_total).to_f
  end 

  def add_product(prod_name, price)
    if @products.key?(prod_name)
      raise ArgumentError.new("Sorry, no item by that name exists in the order")
    else
      @products[prod_name] = price
    end
  end


  def self.all
    order_csv = CSV.read("data/orders.csv")
    all_orders = []
    
    order_csv.each do |info|
      products_price = {} 

      info[1].split(";").each do |product|
        product = product.split(":")
        products_price[product[0]] = product[1].to_f
      end

      new_order = self.new(info[0].to_i, products_price, Customer.find(info[2].to_i), info[3].to_sym)
      all_orders << new_order
    
    end
  
    return all_orders
  end 

  def self.find(id)
    desired_order = (self.all).find { |order| order.id == id }

    return desired_order
  end

end