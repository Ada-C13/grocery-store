class Order
	attr_reader :id
	attr_accessor :products, :customer, :fulfillment_status

	def initialize(id, products, customer, fulfillment_status = :pending)
		@id = id
		@products = products
		@customer = customer
		@fulfillment_status = fulfillment_status
		
		valid_statuses = [:pending, :paid, :processing, :shipped, :complete]
		raise ArgumentError.new("The fulfillment status is not valid!") if !valid_statuses.include?(@fulfillment_status)
	end

	def fulfillment_status
		return @fulfillment_status
	end
end