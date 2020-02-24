#!/usr/bin/ruby
# 
# Title  : Customer - Ada Cohort 13 - Space
# Author : Suely Barreto
# Date   : February 2020
# 
require 'csv'

# Create a Class Customer
class Customer

  # Generator
  attr_reader   :id
  attr_accessor :email, :address

  # Constructor
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # Class Method to read from a CSV file and return an array of customers
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

  # Class Method to find a customer by the customer id
  def self.find(id)
    return Customer.all.select { |c| c.id == id }.first
  end

  # Class Method to save customer info to a CSV file
  def self.save(filename, new_customer)
    CSV.open(filename, "w") do |csv|
      csv << [new_customer.id,
              new_customer.email,
              new_customer.address[:street],
              new_customer.address[:city],
              new_customer.address[:state],
              new_customer.address[:zip]]
    end
  end
end