require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    unless valid_status.include?(fulfillment_status)
      raise ArgumentError.new "#{fulfillment_status} is not a valid status."
    end
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    total = (@products.sum { |product, price| price * 1.075}).round(2)
    return total
  end

  def add_product(name, price)
    if @products.has_key?(name)
      raise ArgumentError.new "The product #{name} is already added to the order!"
    else
      @products[name] = price
    end
  end

  def remove_product(name)
    if @products.has_key?(name)
      @products.delete(name)
    else
      raise ArgumentError.new "The product #{name} is not present in the order."
    end
  end

  def self.all
    all_orders = []
    CSV.read('../data/orders.csv').each do |row|
      products_hash = {}
      all_products = row[1].split(";")
      all_products.each do |product|
        product_details = product.split(":")
        products_hash[product_details[0]] = product_details[1].to_f
      end
      all_orders << Order.new(row[0].to_i, products_hash, Customer.find(row[2].to_i), row[3].to_sym)
    end
    return all_orders
  end

  def self.find(id)
    all_orders = self.all
    all_orders.delete_if { |order|order.id != id}
    if all_orders.length == 0
      return nil
    end
    return all_orders[0]
  end

end