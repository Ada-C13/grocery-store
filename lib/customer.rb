require 'awesome_print'
require 'csv'
require 'pry'
require_relative 'order'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #integer
    @email = email #string
    @address = address #hash
  end

  def self.all
    customers_list = []
    CSV.read("./data/customers.csv").each do |customer|
      id = customer[0].to_i
      email = customer[1]
      @address = {
        street: customer[2],
        city: customer[3],
        state: customer[4],
        zip: customer[5]
      }
      client = Customer.new(id, email, @address)
      customers_list << client
    end
    return customers_list
  end

  def self.find(id)
    Customer.all.find do |customer|
      customer.id == id
    end
  end

  def self.save(filename, new_customer)
    street = new_customer.address[:street]
    city = new_customer.address[:city]
    state = new_customer.address[:state]
    zip = new_customer.address[:zip]
    customer_info = [new_customer.id, new_customer.email, street, city, state, zip]
    CSV.open(filename, "a+") do |csv|
      csv << customer_info
    end
  return true
  end
end