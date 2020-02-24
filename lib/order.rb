require 'csv'

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id,products, customer, fulfillment_status = :pending)
    check_status(fulfillment_status)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  # Method to check in the status is correct
  def check_status(value)
    status_array = [ :pending, :paid, :processing, :shipped, :complete]
    if status_array.include?(value)
      return value
    end
    return raise ArgumentError
  end

  def total
    total = 0
    tax =  1.075
    @products.map do |product, price|
      total += price
    end
    order_total = (total * tax).round(2)
    return order_total
  end

  def add_product(name, price)
    has_value = @products.has_key?(name)  
    if has_value == true
      raise ArgumentError
    else
      @products[name] = price
    end
    return @products
  end

  def delete_product(name)
    p @products
    has_value = @products.has_key?(name)  
    p has_value
    if has_value == false
      raise ArgumentError
    else
      @products.delete(name)
    end
    return @products
  end

  def self.all
    file = 'data/orders.csv'
    data = CSV.read(file)

    orders = Array.new
    for index in (0...data.length)
      # Split each product by ; in the index 1
      product = (data[index][1]).split(';')
      @products = {}
      # For each product, it creates a hash split it by :
      product.each do |input|
        k,v = input.split(':')
        @products[k] = v.to_f
      end
    # Creating an Orden intance per line in the CSV file
    orders << Order.new(data[index][0].to_i, @products, Customer.find(data[index][-2].to_i), data[index].last.to_sym) 
    end
    return orders
  end

  def self.find(id)
    orders_info = Order.all
    orders_info.select do |order|
      if order.id == id
        return Order.new(order.id, order.products, order.customer, order.fulfillment_status)
      end
    end
  return nil
  end
end
