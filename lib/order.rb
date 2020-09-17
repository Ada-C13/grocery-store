require_relative 'customer.rb'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@OPTIONS = %i[pending paid processing shipped complete]

  def initialize(id, products, customer, fulfillment_status= :pending)
    @id =id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    unless @@OPTIONS.include? @fulfillment_status
      raise ArgumentError.new("This is not a valid fulfillment options")
    end
  end

  def total
    total = @products.values.sum + (@products.values.sum*0.075)
    return total.to_f.round(2)
  end

  def add_product(name, price)
    if @products.include? name
      raise ArgumentError.new("OH NO! There is already an item like that!!!")
    else
       @products[name] = price
    end
    return products
  end

  def remove_product(product_name)
    if products.keys.include? product_name
      products.delete(product_name)
    else
      raise ArgumentError.new("There is no such product!")
    end
  end

  def self.all
    orders = []
    
    orders_from_csv = CSV.read('data/orders.csv')
    orders_from_csv.each do |each_order|
      temp_hash = {}
      products_array = []
      products_array << each_order[1] 
      products_array.each do |product_list|
        temp_array = []
        temp_array = product_list.split(";")
        temp_array.each do |product|
          item_array = []
          item = product.split(":")
          temp_hash[item[0]] = item[1].to_f
        end 
      end
      orders << Order.new(each_order[0].to_i, temp_hash, Customer.find(each_order[2].to_i), each_order[3].to_sym)
    end
    return orders
  end

  def self.find(id)
    return self.all[id-1]
  end

  def self.find_by_customer(customer_id)
    customer_order = []
    Order.all.each do |order|
      if customer_id == order.customer.id
        customer_order<< order
      end
    end
    return customer_order
  end
end