require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all()
    file = "./data/customers.csv"
    data = CSV.read(file) #returns an array of arrays

    customers = []

    data.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = {
        street: customer[2],
        city: customer[3],
        state: customer[4],
        zip: customer[5],
      }

      current_customer = Customer.new(id, email, address)

      customers << current_customer
    end

    return customers
  end

  def self.find(id)
    customers = Customer.all

    customers.each do |customer_object|
      if customer_object.id == id
        return customer_object
      end
    end

    return nil
  end
end
