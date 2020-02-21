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
    CSV.read('data/customers.csv').map do |cust|
      id = cust[0].to_i
      email = cust[1]
      address = {
        street: cust[2],
        city: cust[3],
        state: cust[4],
        zip: cust[5]
      }

      Customer.new(id, email, address)
    end
  end

  def self.find(id)
    customers = self.all
    customers.each do |cust|
      if cust.id == id
        return cust
      end
    end
    return nil
  end
end

Customer.find(2)