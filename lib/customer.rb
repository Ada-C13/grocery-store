require "csv"
require "awesome_print"

# create a customer class
class Customer
  attr_reader :id
  attr_accessor :email, :address 

  def initialize(id, email, address) # The initialize creates customer list
    @id = id
    @email = email # string
    @address = address # hash
  end

  # Wave 2
  def self.all
    # returns a collection of Customer instances, representing all of the Customers described in the CSV file
    allcustomers = CSV.read("data/customers.csv").map(&:to_a)
    customers = []
    # iterate through the allcustomers array 
    allcustomers.each do |customer_data|
      # taking each customer and extracting id at index 0
      customers << Customer.new(customer_data[0].to_i, customer_data[1], customer_data[2..5]) # each customer object here will be an instance of that customers array
    end
    # iterate over each customers addresses
    customers.each do |customer|
      address = {} # create a hash
      # assign keys to the values (data) for their addresses
      address[:street] = customer.address[0]
      address[:city] = customer.address[1]
      address[:state] = customer.address[2]
      address[:zip] = customer.address[3]

      customer.address = address
    end
    return customers    
  end

  # return an instance of Customer where the value of the id field in the CSV matches the passed parameter
  def self.find(id)
    Customer.all.find { |customer| customer.id == id }
  end
end


#  # wave 3
#   def save(filename, new_customer)
#     CSV.open("data/customers.csv", "a+") do |csv|
#       csv << new_customer
#     end
#   end not finished

# 1,leonard.rogahn@hagenes.org,71596 Eden Route,Connellymouth,LA,98872-9105

