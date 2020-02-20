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

	def add_product(product, price)
		if @products.keys.include?(product)
			raise ArgumentError.new("Product is already included.")
		else
			@products[product] = price
		end
	end
end