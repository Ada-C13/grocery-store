require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id , email, address)
    @id = id 
    @email = email
    @address = address
  end

  def self.all
    customers_data = CSV.read("./data/customers.csv") 
    customers = []
    customers_data.each do |customer|
      customers << Customer.new(customer[0].to_i, customer[1],{street: customer[2], city: customer[3], state: customer[4], zip: customer[5]})
    end
    return customers
  end

  def self.find(id)
    return self.all[id - 1]
  end
end

customer1 = Customer.new("Sharon", "keikei@gmail.com", {Street: "123 Main", City: "Los Angeles", Zip: 90024})
customer2 = Customer.new("Cindy", "cindy@gmail.com", {Street: "123 First street", City: "Seattle", Zip: 90024})
customer3 = Customer.new("Joseph", "keikei@gmail.com", {Street: "1409 Midvale Ave", City: "Los Angeles", Zip: 90024})

