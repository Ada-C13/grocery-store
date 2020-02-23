require 'csv'

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status

  def initialize(id,products, customer, fulfillment_status = :pending)
    check_input(fulfillment_status)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end


  def check_input(value)
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
      product = (data[index][1]).split(';')
      @products = {}
      product.each do |input|
        k,v = input.split(':')
        @products[k] = v.to_f
      end
    orders << Order.new(data[index][0].to_i, @products, Customer.find(data[index][-2].to_i), data[index].last.to_sym) 
    end
    return orders
  end

end

# p Order.all.product
# new_order = Order.new("123")
# puts new_order.customer_info("dd")
# puts new_order.fulfillment_status
# puts new_order.total