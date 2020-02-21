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
end