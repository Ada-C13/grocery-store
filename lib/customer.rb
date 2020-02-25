require "csv"

class Customer

    attr_reader :id, :email_address, :delivery_address

    def initialize(id, email_address, delivery_address)
        @id = id
        @email_address = email_address
        @delivery_address = delivery_address
    end


    def self.all
      customers = []
      CSV.open("data/customers.csv", "r") do |file|
        file.each do |row|
          address = {}
          address[:street] = row[2]
          address[:city] = row[3]
          address[:state] = row[4]
          address[:zip] = row[5]
          customer = Customer.new(row[0].to_i, row[1], address)
          customers << customer
        end
      end
      return customers
    end

 end

