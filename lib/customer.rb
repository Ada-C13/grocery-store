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

  # Optional wave 3
  def self.save(filename, new_customer)
    CSV.open(filename,'a') do |csv|
      new_customer_data = [new_customer.id, new_customer.email, new_customer.address[:street], new_customer.address[:city], new_customer.address[:state], new_customer.address[:zip] ]
      csv << new_customer_data
    end
  end
end

