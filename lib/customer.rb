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
end



