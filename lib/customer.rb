require_relative 'order.rb'
require 'csv'
require 'awesome_print'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = CSV.read('data/customers.csv')
    list = customers.map do |customer|
      id = customer[0].to_i
      email = customer[1]
      street = customer[2]
      city = customer[3]
      state = customer[4]
      zip = customer[5]
      customer_record = Customer.new(id,email,{:street=> street, :city => city, :state => state, :zip => zip})
    end
    return list
  end

  def self.find(id)
    list_of_customers = Customer.all
    list_of_customers.each do|customer|
    customer.id
    end 
  end
  end