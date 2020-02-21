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
		all_customers = [] # Variable holding all customers.

		CSV.read('data/customers.csv').each do |line|
			address = {
				street: line[2], 
				city: line[3], 
				state: line[4], 
				zip: "#{ line[5][0..4].to_i }#{ line[5][5..9].to_i }"
			}
		
			new_customer = self.new(line[0].to_i, line[1], address)
			all_customers << new_customer
		end

		return all_customers
	end

	# Locates the desired customer.
	def self.find(id)
		all_customers = self.all # Variable holding all customers.

		all_customers.each do |customer|
			if id == customer.id
				return customer
			end
		end

		return nil
	end

	# Adds the info of a new customer to a new file.
	def self.save(filename, new_customer)
		new_customer_file = CSV.open(filename, "a+")
		address_array = []

		new_customer.address.values.each do |value|
			address_array << value
		end

		new_customer_file << [new_customer.id, new_customer.email, address_array[0], address_array[1], address_array[2], address_array[3]]
	end

end