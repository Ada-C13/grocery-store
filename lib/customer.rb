require 'pry'
require 'csv'

class Customer
	attr_reader :id
	attr_accessor :email, :address
	@@customer_info = CSV.open("data/customers.csv")
	@@all = []

	def initialize(id, email, address)
		@id = id
		@email = email
		@address = address
	end

	def self.all
		@@customer_info.select do |row|
			row.map!(&:strip)
			@@all << Customer.new(row[0].to_i, row[1], {street: row[2], city: row[3], state: row[4], zip: row[5]})
		end
		return @@all
	end

	def self.find(find_id)
		Customer.all.find {|customer| customer.id == find_id}
	end

	# Writes new customer's information into CSV file
	def self.save(filename, new_customer)
		CSV.open(filename, "a+") do |csv|
			address_array = []
			new_customer.address.each do |k, v|
				address_array << v
			end
			csv << [new_customer.id, new_customer.email] + address_array
		end
		return true
	end

end



