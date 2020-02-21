require "csv"
require_relative "order"

# class definition for Customer
class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customer_data = []
    customers = CSV.read("./data/customers.csv")
    customers.each do |customer|
      read_address = {}
      read_id = customer[0].to_i
      read_email = customer[1]
      read_address[:street] = customer[2]
      read_address[:city] = customer[3]
      read_address[:state] = customer[4]
      read_address[:zip] = customer[5] 
      customer_data << Customer.new(read_id, read_email, read_address)
    end
    return customer_data
  end

  def self.find(id)
    self.all.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end

end
