require_relative 'customer'

class Order
	attr_reader :id
	attr_accessor :products, :customer, :fulfillment_status
	@@order_info = CSV.open("data/orders.csv")
	@@all = []

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

	def self.all
		@@order_info.select do |row|
			row.map!(&:strip)
			product_list = {}
			row[1].split(";").each do |array|
				mod_array = array.split(":")
				product_list[mod_array[0]] = mod_array[1].to_f
			end
		
			@@all << Order.new(row[0].to_i, product_list, Customer.find(row[2].to_i),row[3].to_sym)
		end
		return @@all
	end

	def self.find(find_id)
		Order.all.find {|order| order.id == find_id}
	end

end