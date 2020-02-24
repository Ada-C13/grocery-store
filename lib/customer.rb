require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize (id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customer_csv = CSV.read("data/customers.csv")
    all_customers = []

    customer_csv.each do |info|
      id = info[0].to_i
      email = info[1]
      address = { 
        :num_street => info[2],
        :city => info[3],
        :state => info[4],
        :zip => info[5]
      }
    
      new_customer = Customer.new(id, email, address)
      all_customers << new_customer
    end 
    
    return all_customers
  end

  def self.find(id)
    desired_customer = (self.all).find { |order| order.id == id }
    return desired_customer

    desired_customer.empty? ? nil : desired_customer
  end

end