require 'csv'
require 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError if !([:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status))
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    return 0 if @products.empty?

    total = @products.values.sum
    total += (0.075 * total)
    return total.round(2)
  end

  def add_product(new_product, price)
    raise ArgumentError if @products.include?(new_product)
    @products[new_product] = price
  end

  def self.make_product_list(list)
    split_list = list.split(";")

    nice_product_list = {}
    split_list.each do |product|
      break_at = product.index(":")
      name = product[0...break_at]
      price = (product[(break_at + 1)..-1]).to_f
      nice_product_list[name] = price
    end

    return nice_product_list
  end

  def self.all
    CSV.read('data/orders.csv').map do |order|
      id = order[0].to_i
      products = make_product_list(order[1])
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym

      Order.new(id, products, customer, fulfillment_status)
    end
  end

  def self.find(id)
    orders = self.all
    orders.each do |order|
      return order if order.id == id
    end
    return nil
  end
end

