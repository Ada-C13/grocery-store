require 'csv'

class Order

  attr_accessor :products, :customer, :fulfillment_status
  attr_reader :id

  def initialize(id, products, customer, fulfillment_status=:pending)
    statuses = [:pending, :paid, :processing, :shipped, :complete]
    @id = id
    @customer = customer
    @products = products
    if statuses.include?(fulfillment_status)
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError, "The fulfillment status '#{fulfillment_status}' is not a valid status."
    end
  end

  def total
    sum = @products.values.sum
    sum *= 1.075
    return sum.round(2)
  end

  def add_product(product_name, price)
    if !@products.keys.include?(product_name)
      @products[product_name] = price 
    else
      raise ArgumentError, "The product '#{product_name}' is already in this collection."
    end
  end

  def remove_product(product_name)
    if @products.keys.include?(product_name)
      products.delete(product_name)
    else
      raise ArgumentError, "The product '#{product_name}' is not in this collection."
    end
  end

  def self.all
    #return collection of Order instances in csv file
    orders_array = CSV.read("data/orders.csv", headers: true).map do |row|
      products = row["Products"].split(";") #returns array of "key:value" strings
      products_hash = Hash.new
      products.each do |string|
        key_value_array = string.split(":")
        products_hash[key_value_array[0]] = key_value_array[1].to_f
      end
      Order.new(
        row["ID"].to_i,
        products_hash,
        Customer.find(row["Customer_ID"].to_i),
        row["Status"].to_sym
      )
    end
    return orders_array
  end

  def self.find(id)
    return self.all.find { |order| order.id == id }
  end
end