require_relative 'customer'

class Order
	attr_reader :id
	attr_accessor :products, :customer, :fulfillment_status

	def initialize(id, products, customer, fulfillment_status = :pending)
		@id = id
		@products = products
		@customer = customer
		self.fulfillment_status = fulfillment_status
	end

	def fulfillment_status=(value)
		potential_status = [:pending, :paid, :processing, :shipped, :complete]
		if potential_status.include? value
			@fulfillment_status=(value)
		else
			raise ArgumentError,"Status is bogus"
		end
	end 

	def total
		if @products == {}
			return 0
		else
			return (@products.sum {|product, cost| cost} * 1.075).round(2)
		end
	end

	def add_product(product_name, price)
		if @products.key? product_name
			raise ArgumentError, "Product already exists"
		else
			@products[product_name] = price
		end
	end

	def remove_product(product_name)
		if @products.key? product_name
			products.delete(product_name)
		else
			raise ArgumentError, "Product already does not exist"
		end
	end
end
