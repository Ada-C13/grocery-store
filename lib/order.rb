# test = { "banana" => 1.99, "cracker" => 3.00 }
# puts sum(test)

class Order
  attr_reader :id
  attr_accessor :products, :fulfillment_status, :customer

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    options = [:pending, :paid, :processing, :shipped, :complete]

    unless options.include? fulfillment_status
      raise ArgumentError.new("#{fulfillment_status} is not a valid option, please try again.")
    end
  end

  def total
    to_sum = []
    products.each do |product, price|
      to_sum << price
    end
    first_total = to_sum.sum
    total = (first_total * 1.075).round(2)
    return total
  end

  def add_product(product_name, price)
    if @products.include? product_name
      raise ArgumentError.new("#{product_name} is already included in the product list.")
    else
      @products[product_name] = price
    end
  end

  def self.all
    orders = []
    CSV.open('data/orders.csv', 'r').each do |line|
      order_id = line[0].to_i

      order_customer = Customer.find(line[2].to_i)

      order_fulfillment_status = line[3].to_sym

      products = line[1].split(";")
      product_hash = {}
      products.each do |item|
        key_value = item.split(":")
        product_hash[key_value[0]] = key_value[1].to_f
      end
      order_products = product_hash

      orders << Order.new(order_id, order_products, order_customer, order_fulfillment_status)
    end
    return orders
  end

  def self.find(id)
    orders = self.all
    orders.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end
end


