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
    all_customers = []
    customers = CSV.read('data/customers.csv')
    customers.each do |customer|
        address = {
          street: customer[2],
          city: customer[3],
          state: customer[4],
          zip: customer[5]
        }
        all_customers << Customer.new(customer[0].to_i, customer[1], address)
    end
    return all_customers
  end

  def self.find(id)
    if id <= 0
      return nil
    end
    return Customer.all[id-1]
  end
end