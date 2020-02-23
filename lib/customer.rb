require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address


  def initialize(id, email, address = {})
    @id = id
    @email = email
    @address = address
  end 

  def self.all 
    all_customer = []
     CSV.read('./data/customers.csv').each do |customer| 
      all_customer << Customer.new(customer[0].to_i, customer[1], {
                  :street => customer[2], 
                  :city => customer[3],
                  :state => customer[4],
                  :zip => customer[5]
                })  
    end 
    return all_customer
  end 

  def self.find(id_customer)
    id_find = all.find do |customer|
      id_customer == customer.id
    end 
    return id_find
  end 

end 
