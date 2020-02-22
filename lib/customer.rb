require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address
  # (num, string, hash)
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = CSV.read("./data/customers.csv")
    customers_lists = []
    # form the Customer instances into a format that matches what we have in the Constructor (id is a num, email is a string, address is a hash)
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

  def self.find(id) # num  
    # return an instance of Customer where the value of the if field in the CSV matches the passed id.
    # iterate throug the customers_lists.id
    customers_info = Customer.all
    customers_info.find do |customer|
    # if id == customers_lists.id
      if customer.id == id
       # return that specific instance
        return customer
      end
    end

    return nil
  end
end

# p Customer.all.first
# p Customer.find(1)