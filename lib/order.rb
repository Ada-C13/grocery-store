class Order
    attr_reader :id, :products, :customer, :fulfillment_status

    FULFILLMENT_STATUS = [:paid, :processing, :shipped, :complete, :pending]
    
    def initialized(id, customer, products, fulfillment_status = :pending)
        @id = id 
        @customer = customer
        @products = products
        @fulfillment_status = fulfillment_status

        if FULFILLMENT_STATUS.include?(@fulfillment_status) == false
            raise ArgumentError, "This is not a valid fulfillment status."
        end
    end

    def total
        sum = @products.sum {|products, cost|cost}
        total = (sum * 1.075).round(2)
        return total
    end

    def self.all
        new_order = []
        CSV.open('data/orders.csv', 'r').each do |line|
            new_order << Order.new(line[0], line[1], line[2], line[3])
        end
        return new_order
    end

    def self.find(id)
        Customer.all.find { |customer| customer.id == id }
          if new_customer.id == id
            return new_customer
          end 
        end
      return nil
    end

    def add_product(product_name, price)
        if @products.keys.include?(product_name)
            raise ArgumentError, "This product is already in your order."
        else
            @products[product_name] = price
        end
        return @products
    end
    
    def remove_product(product_name)
        if !(@products.has_key?(product_name))
          return raise ArgumentError, "There is no such product to remove."
        else
          @products.delete_if { |key, value| key == product_name }
        end
    end
end   