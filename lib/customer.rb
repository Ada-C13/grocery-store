require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id,email,address)
    @id = id # a number
    @email = email # a string
    @address = address # a hash
  end

  # class method which reads the customers CSV and returns a collection of those Customer instances
  def self.all
    collection_of_customers = []
    CSV.read("data/customers.csv").map(&:to_a).each do |customer|
      collection_of_customers.push(Customer.new(customer[0].to_i,customer[1],{street: customer[2], city: customer[3], state: customer[4], zip: customer[5]}))
    end
    return collection_of_customers
  end

  # class method which searches for and returns a customer from data in the CSV file based on the customer ID input
 
  def self.find(id)
    return self.all.find { |customer| customer.id == id }
  end

end