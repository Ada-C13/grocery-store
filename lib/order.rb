require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status      

  @@orders_collection = []

  def initialize(id, products, customer, fulfillment_status = :pending)     
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status 

    approved_status = [:pending, :paid, :processing, :shipped, :complete]
    unless approved_status.include?(fulfillment_status)
      raise ArgumentError, 'You must provide one of the following statuses :pending, :paid, :processing, :shipped, :complete'
    end
  end 
  
  def self.create_product_hash (string)
    indv_products = string.split(';')
    product_hash = {}
    separate_price_and_product = indv_products.map {|product_price| product_price.split(':')}
    
    separate_price_and_product.each do |product_info|
      product_hash["#{product_info[0]}"] = product_info[1].to_f
    end
    return product_hash
  end

  def self.order_data
    if @@orders_collection.length != 0
      return
    end

    CSV.read('./data/orders.csv').each do |order|
      order_id = order[0].to_i
      products = create_product_hash(order[1])
      order_customer_id = Customer.find(order[2].to_i)
      status = :"#{order[3]}"

      @@orders_collection << Order.new(order_id, products, order_customer_id, status)
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
    self.order_data
    return @@orders_collection
  end

  def self.find(id)
    all_orders = self.all
    all_orders.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end
end


