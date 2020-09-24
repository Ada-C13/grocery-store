require 'csv'

class Customer
	attr_accessor :email, :address
	attr_reader :id

	def initialize(id, email, address)
		@id = id
		@email = email
		@address = address
	end

	def self.all
		CSV.read('data/customers.csv', converters: :numeric).map do |customer|
			self.new(
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

	def self.find(id)
		customers = self.all
		return customers.find do |customer|
			customer.id == id
		end
	end
end