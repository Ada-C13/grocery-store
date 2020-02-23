require 'csv'



class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status      

  @@orders_collection = []

  def initialize(id, products, customer, fulfillment_status = :pending)     
    @id = id
    @products = products #||= {}
    @customer = customer
    @fulfillment_status = fulfillment_status 

    approved_status = [:pending, :paid, :processing, :shipped, :complete]
    unless approved_status.include?(fulfillment_status)
      raise ArgumentError, 'You must provide one of the following statuses :pending, :paid, :processing, :shipped, :complete'
    end
  end 

  def self.order_data
    CSV.read('./data/orders.csv').each do |order|
      @@orders_collection << order
    end
  end

  def total

    summed_total = 0
    @products.each {|product, price| summed_total += price}

    return post_tax_price = (summed_total*1.075).round(2) 
  end

  def add_product(product_name,price)
    while @products.include?(product_name)
      raise ArgumentError, 'You must provide a new product!'
    end
    
    @products[product_name] = price
  
  end

  def self.all
    return @@orders_collection

  end

  def find(id)

  end

end


Order.order_data



