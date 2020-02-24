class Order
    attr_reader :id
    attr_accessor :products, :customer, :fulfillment_status

    def initialize(id, products, customer, fulfillment_status = :pending)
        @id = id
        @products = products
        @customer = customer
        @fulfillment_status = fulfillment_status
        # If invalid fulfillment status is given, raise ArgumentError
        possible_status = [:pending, :paid, :processing, :shipped, :complete]
        if !(possible_status.include?(fulfillment_status))
            raise ArgumentError.new("That is not a valid fulfillment status")
        end
    end

    def total
        tax = 0.075
        products_sum = products.values.sum
        total_price = (products_sum + (products_sum * tax)).round(2)
        return total_price
    end

    def add_product(product_name, product_price)
        # if product already exists, raise ArgumentError
        if products.key?(product_name)
            raise ArgumentError.new("Product already exists")
        end
        products[product_name] = product_price
    end

    def self.all
        # returns a collection of Order instances, representing all of the Orders described in the CSV file
        all_orders = []
        CSV.read("data/orders.csv").each do |order_details|
            # create hash of products with prices from order. # This would be a great piece of logic to put into a helper method
            orders_hash = {}
            orders = order_details[1].split(";")
            orders.each do |product|
                product_details = product.split(":")
                orders_hash[product_details[0]] = product_details[1].to_f
            end

            # create order with ID, orders hash, customer, fulfillment status
            order_data = Order.new(order_details[0].to_i, orders_hash, Customer.find(order_details[2].to_i), order_details[3].to_sym)
            all_orders << order_data
        end
        return all_orders
    end

    def self.find(id)
        # returns an instance of Order where the value of the id field in the CSV matches the passed parameter
        Order.all.find { |order| order.id == id }
    end
end