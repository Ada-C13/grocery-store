require 'csv'

class Customer
  
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id,email,address)
    @id = id # a number
    @email = email # a string
    @address = address # a hash
  end

  def self.all
    collection_of_customers = []
    CSV.read("data/customers.csv").map(&:to_a).each do |customer|
      collection_of_customers.push(Customer.new(customer[0].to_i,customer[1],{street: customer[2], city: customer[3], state: customer[4], zip: customer[5]}))
    end
    # print collection_of_customers[0].email
    # print "\n"
    return collection_of_customers
  end
# self.find(id) - returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
# Customer.find should not parse the CSV file itself. 
# Instead it should invoke Customer.all and search through the results for a customer with a matching ID

  def self.find(id)
    # self.all.each do |customer|
    #   if customer.id == id
    #     return customer
    #   end
    # end
    # return nil
    return self.all.find { |customer| customer.id == id }
  end

end

# puts "#{Customer.find(3).email}"