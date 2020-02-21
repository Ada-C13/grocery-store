#!/usr/bin/ruby
# 
# Title  : Order - Ada Cohort 13 - Space
# Author : Suely Barreto
# Date   : February 2020
# 

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id.to_i
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid = %i[pending paid processing shipped complete]

    unless valid.include?(@fulfillment_status)
      raise ArgumentError, "Invalid Status"
    end
  end

  def total
    sum   = @products.values.sum
    tax   = sum * 0.075
    total = (sum + tax).round(2)
    return total
  end

  def add_product(name, price)
    if @products.include?(name)
      raise ArgumentError, "Product already in this order"
    end
    @products[name] = price
  end

  def remove_product(name)
    unless @products.include?(name)
      raise ArgumentError, "Product not in this order"
    end
    @products.delete(name)
  end

end

