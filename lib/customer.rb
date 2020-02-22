require "awesome_print"
require "csv"
require_relative "order"

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
      @address = {
      street: customer[2],
      city: customer[3],
      state: customer[4],
      zip: customer[5]
      }
      client = Customer.new(customer[0].to_i, customer[1], @address)
      customers_list << client
    end
    return customers_list
  end

  def self.find(id)
    Customer.all.find do |customer|
      customer.id == id
    end
  end
end
