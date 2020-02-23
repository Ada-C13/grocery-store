# frozen_string_literal: true

require_relative 'customer.rb'
require 'csv'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  VALID_STATUS = %i[pending paid processing shipped complete].freeze

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer

    raise ArgumentError unless VALID_STATUS.include?(fulfillment_status)

    @fulfillment_status = fulfillment_status
  end

  def total
    sum = 0
    @products.each do |_product_name, product_price|
      sum += product_price
    end
    sum = (sum + (sum * 0.075).round(2))
    sum
  end

  def add_product(product_name, product_price)
    if products.key? product_name
      raise ArgumentError
    elsif @products[product_name] =
            product_price
      true
    end
  end

  #  def self.products_to_string(csv_input)
  #     products = {}
  #     product_purchase = csv_input.split (";")
  #     product_purchase.each do |item|
  #      product_name, product_value = item.split ":"
  #       products[product_name] = product_value
  #     end
  #     return products

  #   end
  def self.products_hash(str)
    product_string = str.split(':')
    product_string.map! do |element|
      element.split(';')
    end
    product_hash = {}
    product_string.each do |product_purchase|
      product_hash[product_purchase[0]] = product_purchase[1]
    end
    product_purchase
  end

  def self.all
    orders = []
    CSV.read('./data/orders.csv').each do |order|
      order_info = Order.new(order[0].to_i, Order.products_hash(order[1]), Customer.find(order[2].to_i), order[3].to_sym)
      orders << order_info
    end
    orders
end

  def self.find(id)
    order_array = Order.all

    order_array.each do |order|
      return order if order.id == id
    end
    nil
  end
end
