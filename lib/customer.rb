require 'csv'

class Customer
  
  attr_reader :id
  attr_accessor :email, :address 
  
  # method for initialize instance of customer
  def initialize(id, email, address)
    @id = id # this is an integer
    @email = email # this is a string
    @address = address # this is a hash
  end
  
  # reads CSV file data, instantiates customers, returns a list of all customers
  def self.all
    all_customers = []
    customers = CSV.read('./data/customers.csv')
    
    customers.each do |customer|
      id = customer[0].to_i
      email = customer[1]
      address = { street: customer[2], city: customer[3], state: customer[4], zip: customer[5]}
      
      new_customer = Customer.new(id, email, address)
      
      all_customers << new_customer
      
    end
    
    return all_customers
  end
  
  # method for locating customer by id number, returns instance of customer
  def self.find(id)
    all_customers = self.all
    
    found_customer_array = all_customers.select { |customer| customer.id == id }
    
    if found_customer_array.empty?
      return nil
    else
      found_customer = found_customer_array[0]
    end
    
    return found_customer
  end
  
end