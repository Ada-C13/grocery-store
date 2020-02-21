require 'csv'
customer_data = CSV.read('data/customers.csv')


class Customer
  attr_reader :id, :all_customers
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all_customers = []

    CSV.read('data/customers.csv').each do |customer|
      customer_address = {}
  
      customer_id = customer[0].to_i
      customer_email = customer[1]
      customer_address[:street] = customer[2]
      customer_address[:city] = customer[3]
      customer_address[:state] = customer[4]
      customer_address[:zip] = customer[5]

      all_customers << Customer.new(customer_id, customer_email, customer_address)
    end
    
    return all_customers
  end

  def find(id)
    Customer.all 
  end
end

