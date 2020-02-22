#!/usr/bin/ruby
# 
# Title  : Customer - Ada Cohort 13 - Space
# Author : Suely Barreto
# Date   : February 2020
# 
require 'csv'

class Customer

  attr_reader   :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    filename      = "data/customers.csv"
    csv_all       = CSV.read(filename)

    all_customers = []
    csv_all.each do |csv_row|

      id      = csv_row[0].to_i
      email   = csv_row[1]
      address = { street: csv_row[2], city: csv_row[3], state: csv_row[4], zip: csv_row[5] }

      customer = Customer.new(id, email, address)
      all_customers << customer

    end
    return all_customers
  end

  def self.find(id)
    return Customer.all.select { |c| c.id == id }.first
  end

end


