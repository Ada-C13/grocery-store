# require_relative 'data/customers.csv'
require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address, :all_customers

  def initialize(id = 0, email = '', address = {})
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all_customers = []
    CSV.read('../data/customers.csv').each do |row|
      address = {
        street: row[2],
        city: row[3],
        state: row[4],
        zip: row[5]
      }
      all_customers << Customer.new(row[0].to_i, row[1].to_s, address)
    end
    return all_customers
  end

  def self.find(id)
    all_customers = self.all
    all_customers.delete_if { |customer| customer.id != id}
    if all_customers.length == 0
      return nil
    end
    return all_customers[0]
  end
end