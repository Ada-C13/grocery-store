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
      all_customers = CSV.read('../data/customers.csv').map do |line|
        Customer.new(id = line[0].to_i,
        email = line[1],
        address = {
          street: line[2],
          city: line[3],
          state: line[4],
          zip: line[5]
        })
      end
      return all_customers
    end

  def self.find(id)
    Customer.all.find do |each_customer|
      if each_customer.id == id
        return each_customer
      else
        nil
  end
end
end
end