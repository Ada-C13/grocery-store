require 'csv'

class Customer

	attr_reader :id
	attr_accessor :email, :address

	def initialize(id, email, address)
		@id = id
		@email = email
		@address = address
	end

	# Finds all customers.
	def self.all
		all_customers = []

		CSV.read('data/customers.csv', headers: false).each do |line|
			new_customer = self.new(line[0].to_i, line[1], {street: line[2], city: line[3], state: line[4], zip: "#{ line[5][0..4].to_i }#{ line[5][5..9].to_i }"})
			all_customers << new_customer
		end

		return all_customers
	end

	# Locates the desired customer.
	def self.find(id)
		all_customers = self.all

		all_customers.each do |customer|
			if id == customer.id
				return customer
			end
		end

		return nil
	end

end