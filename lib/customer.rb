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
    customer_instances = CSV.read("data/customers.csv").map do |customer_data|
      id = customer_data[0].to_i
      email = customer_data[1]
      address = {
        :street => customer_data[2],
        :city => customer_data[3],
        :state => customer_data[4],
        :zip => customer_data[5]
      }

      Customer.new(id, email, address)
    end

    # Return a collection of Customer instances
    return customer_instances
  end 


  def self.find(id)
    customer_instances = self.all
    
    found_customer_instance = customer_instances.find do |customer_instance| 
      customer_instance.id == id
    end 

    # Return an instance of Customer
    return found_customer_instance
  end 


  # Wave 3 - Optional
  def self.save(filename, new_customer)
    CSV.open(filename, 'a') do |csv|
      id = new_customer.id 
      email = new_customer.email 
      address = new_customer.address.values

      new_customer_data = [id, email, *address]
      csv << new_customer_data   
    end
    return true
  end 
end 
