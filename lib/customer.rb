require 'pry'
require 'csv'

class Customer
	attr_reader :id
	attr_accessor :email, :address
	@@all = []

	def initialize(id, email, address)
		@id = id
		@email = email
		@address = address
		@@all << self
	end

	def self.all
		@@all
	end

	def self.find(find_id)
		@@all.find {|customer| customer.id == find_id}
	end

end