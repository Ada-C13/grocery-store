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

