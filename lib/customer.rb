require 'csv'

class Customer
    attr_reader :id
    attr_accessor :email, :address

    def initialize(id, email, address)
        @id = id
        @email = email
        @address = address
    end

    # Wave 2 methods
    def self.all
        # returns collection of Customer instances, representing all of the Customer in the CSV file
        all_customers = []
        CSV.read("data/customers.csv").each do |customer_details|
            customer_data = Customer.new(customer_details[0].to_i, customer_details[1].to_s, {street: customer_details[2], city: customer_details[3], state: customer_details[4], zip: customer_details[5]})
            all_customers << customer_data
        end
        return all_customers
    end

    def self.find(id)
        Customer.all.find { |customer| customer.id == id }
    end
end