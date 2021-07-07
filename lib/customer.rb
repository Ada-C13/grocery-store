
require 'csv'

# Class that holds customer information
class Customer
  attr_reader :id
  attr_accessor :email, :address
  
  def initialize(id, email_address, delivery_address)
    @id = id
    @email= email_address
    @address = delivery_address
  end
  
  # Load data in CSV to Customer class
  def self.all
    file = CSV.read('data/customers.csv').map(&:to_a)
    
    all_customers  = file.map do |new_c|
      address = { street: new_c[2], city: new_c[3], state: new_c[4], zip: new_c[5] }
      
      Customer.new(new_c[0].to_i, new_c[1], address)
    end
  end
  
  # Find Customer object if customer id is available
  def self.find(id)
    all_customers = Customer.all

    all_customers.find { |customer| customer.id == id }
  end
  
  # Save customer into CSV file
  def self.save(filename)
    all_customers = Customer.all
    
    CSV.open(filename, "w") do |file|
      all_customers.each do |customer|
        file << [customer.id, customer.email, customer.address[:street], customer.address[:city], customer.address[:state], customer.address[:zip]]
      end
      return true
    end
  end
end