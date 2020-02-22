require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = CSV.read("./data/customers.csv")
    customers_lists = []
    
    customers.each do |line|
      hash_address = {
        :street => line[2], 
        :city => line[3], 
        :state => line[4], 
        :zip => line[5]
      }
      customers_lists << Customer.new(line[0].to_i, line[1], hash_address)
    end
    return customers_lists
  end

  def self.find(id)
    customers_info = Customer.all
    customers_info.find do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end
end
