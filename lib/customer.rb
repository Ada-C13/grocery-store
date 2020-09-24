require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id 
    @email = email
    @address = address
  end 

  def self.all
    array_of_customers = []
    CSV.foreach("../data/customers.csv") do |row|
      address = {:street => row[2] , :city => row[3], :state => row[4], :zip => row[5]}
      cust = Customer.new(row[0].to_i, row[1], address)
      array_of_customers << cust
    end 
    return array_of_customers
  end 

  def self.find(id, function=:all)
    self.all.each do |customer|
      if customer.id.to_i == id.to_i
         return customer 
      end 
    end
    return nil
  end 
  
end 

