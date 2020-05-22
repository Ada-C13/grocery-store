# #Wave 1
# # Create a class called Customer
require 'awesome_print'
require 'csv'
class Customer
  attr_reader :id 
  attr_accessor :email, :address
  
  def initialize(id, email, address = {})
    @id = id
    @email = email
    @address = address
  end

  # Create Customer self.all

  def self.all
    customers = []
    CSV.read('./data/customers.csv').each do |customer|
      customers << (Customer.new(customer[0].to_i, customer[1], {:street =>customer[2],:city => customer[3],:state=> customer[4],:zip => customer[5]}))
    end
    return customers
  end

  def self.find(id)
    Customer.all.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end


  # customers = Customer.all
  # print customers

  # customers = []
  # CSV.read('../data/customers.csv').each do |customer|
  #   customers << (Customer.new(customer[0], customer[1], {:street =>customer[2],:city => customer[3],:state=> customer[4],:zip => customer[5]}))
  # end

  # print customers
  
  
    










end

# customers = CSV.read('../data/customers.csv')
# customers


