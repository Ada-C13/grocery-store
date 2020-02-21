require 'csv'
require_relative 'customer.rb'

class Order

	attr_reader :id
	attr_accessor :products, :customer, :fulfillment_status

	def initialize(id, products, customer, fulfillment_status = :pending)
		if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status) != true
			raise ArgumentError.new("Invalid fulfillment status passed.") 
		end
		@id = id
		@products = products
		@customer = customer
		@fulfillment_status = fulfillment_status
	end

	# Finds all orders.
	def self.all
		all_orders = []

		CSV.read('data/orders.csv').each do |line|
			customer_products = {}
			
			line[1].split(';').each do |product|
				customer_products[product.split(':')[0]] = product.split(':')[1].to_f
			end

			new_order = self.new(line[0].to_i, customer_products, Customer.find(line[2].to_i), line[3].to_sym)
			all_orders << new_order
		end

		return all_orders
	end

	# Locates a specific order.
	def self.find(id)
		all_orders = self.all

		all_orders.each do |order|
			if id == order.id
				return order
			end
		end

		return nil
	end

	# Totals the prices of the product list.
	def total
		total = 0.0
		if @products.length == 0
			return total
		else
			@products.values.each do |price|
				total += price
			end
			return (total * 1.075).round(2)
		end
	end

	# Adds a product to the list.
	def add_product(product, price)
		if @products.keys.include?(product)
			raise ArgumentError.new("Product is already included.")
		else
			@products[product] = price
		end
	end

	# Removes a product from the list.
	def remove_product(product)
		if @products.keys.include?(product) == false
			raise ArgumentError.new("Product was not found in list.")
		else
			@products.delete(product)
		end
	end
end