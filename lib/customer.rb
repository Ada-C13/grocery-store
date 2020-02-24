# customer.rb

require 'csv'

class Customer 

  attr_accessor :email, :address
  attr_reader :id, :all_customers
  
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end 

  def self.all
    all_customers = []
    CSV.read("../data/customers.csv").each do |customer|
      address = {street: customer[2], city: customer[3], state: customer[4], zip: customer[5]}
      unique_customer = Customer.new(customer[0].to_i, customer[1], address)
      all_customers << unique_customer
    end
    return all_customers
  end 

  def self.find(id)
    customer_list = Customer.all
    customer_list.each do |customer|
      if customer.id == id
        return customer 
      end 
    end
    return nil
  end

end 