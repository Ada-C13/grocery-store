require "csv"
require "awesome_print"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id #number
    @email = email #string
    @address = address #hash
  end

  #write method to return an instance of Customer
  def self.all
    data = CSV.read("data/customers.csv")
    customers = data.map do |customer|
      customer_id = customer[0].to_i
      customer_email = customer[1]
      address = {
        street: customer[2],
        city: customer[3],
        state: customer[4],
        zip: customer[5]
      }
      Customer.new(customer_id, customer_email, address)
    end
    return customers
  end

  #find the id that matches
  def self.find(id)
    all_customers = self.all
    all_customers.find do |customer| 
        id == customer.id 
    end 
  end

end
