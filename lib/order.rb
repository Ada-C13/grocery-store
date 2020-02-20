class Order

	attr_reader :id
	attr_accessor :fulfillment_status

	def initialize(id, products, customer, fulfillment_status = :pending)
		if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status) != true
			raise ArgumentError.new("Invalid fulfillment status passed.") 
		end
		@id = id
		@products = products
		@customer = customer
		@fulfillment_status = fulfillment_status
	end
	
end