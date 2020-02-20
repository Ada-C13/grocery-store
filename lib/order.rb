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
end