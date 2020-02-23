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
    @products.each do |product_name, product_price|
      sum += product_price
    end
    sum = (sum + (sum * 0.075).round(2))
    sum
  end

  def add_product(product_name, product_price)
    if products.key? product_name
      raise ArgumentError
    else @products[product_name] =
           product_price
         true
    end
  end

def self.all
products_item = {}
orders_info = orders.each do |order|
  id = order[0].to_i
  products = order[1].split(";")
  products.each do |item|
    product_name,product_price = item.split":"
   products_item[product_name] = product_price
   orders_info = Order.new(id,customer,products{product_name:product_name,product_price:product_price})

end 
end
  # def self.all
  #   orders = CSV.read('data/orders.csv')
  #   orders_info = orders.map do |order|
  #     id = order[0].to_i
  #     products = order[1].split(";")
  #     products.each do |product|
  #       product_name = product.split(":")[0]
  #       product_price = product.split(":")[1]
  #       orders_info = Order.new(id,customer,products{product_name:[product_name,product_price:[product_price]})
  #       end
  #   end
  # end

  #  def self.all
  #   orders = CSV.read('data/orders.csv')
  #   orders_info = orders.map do |order|
  #     id = customer[0].to_i
  #     product = customer[1]
  #     customer_id = customer[2]
  #     status = customer[3]
  #     orders_info = Order.new(product: product state, zip: zip })
  #   end
  #   list
  # end

  # def self.find(id)
  #   list_of_customers = Customer.all
  #   list_of_customers.each do |customer|
  #     return customer if customer.id == id
  #   end
  # end
