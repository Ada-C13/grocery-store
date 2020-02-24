require 'csv'

class Customer
	attr_accessor :email, :address
	attr_reader :id

	def initialize(id, email, address)
		@id = id
		@email = email
		@address = address
	end

	# self.all - returns a collection of Customer instances, representing all of the Customer described in the CSV file
	def self.all
		CSV.read('data/customers.csv', converters: :all).map do |customer|
			Customer.new(
				customer[0],
				customer[1],
				{ 
				street: customer[2],
				city: customer[3],
				state: customer[4],
				zip: customer[5]
				}
			)
		end
	end

	# self.find(id) - returns an instance of Customer where the value of the id field in the CSV matches the passed parameter

	# Customer.find should not parse the CSV file itself. Instead it should invoke Customer.all and search through the results for a customer with a matching ID.

end