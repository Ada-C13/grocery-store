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

  # def self.fufillment_status
  #   if VALID_STATUS.include?(fulfillment_status)
  #     @fulfillment_status = fulfillment_status
  #     return false
  #   else
  #     raise ArgumentError.new('Invaild Status')
  #   end
  # end
end
