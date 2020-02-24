require 'csv'
require_relative 'customer'

class Order
	attr_reader :id
	attr_accessor :products, :customer, :fulfillment_status

	VALID_STATUSES = [:pending, :paid, :processing, :shipped, :complete]

	def initialize(id, products, customer, fulfillment_status = :pending)
		@id = id
		@products = products
		@customer = customer
		@fulfillment_status = fulfillment_status

		raise ArgumentError.new("The fulfillment status is not valid!") if !VALID_STATUSES.include?(@fulfillment_status)
	end

	def add_product(name, price)
		raise ArgumentError.new("A product with this name has already been added to the order!") if @products.key?(name)
		
		@products.store(name, price)
	end

	def total
		sum = @products.values.reduce(:+)
		return @products == {} ? 0 : (sum * 1.075).round(2)
	end
	
	# When invoked, this method creates a hash by splitting a string at each semicolon, then mapping each smaller string, split by a colon, into a key-value pair (Source: 200_success, https://codereview.stackexchange.com/questions/80572/parsing-a-string-of-the-form-key1-value1key2-value2-into-a-hash)
	def self.all
		CSV.read('data/orders.csv', converters: :numeric).map do |order|
			@products = Hash[
				order[1].split(';').map do |product|
					name, price = product.split(':')
					[name, price.to_f]
				end
			]

			self.new(
				order[0],
				@products,
				Customer.find(order[2]),
				order[3].to_sym
			)
		end
	end

	def self.find(id)
		orders = self.all
		return orders.find do |order|
			order.id == id
		end
	end

	def self.find_by_customer(customer_id)
		orders = self.all
		return orders.select do |order|
			order.customer.id == customer_id
		end
	end
end