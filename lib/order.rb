require_relative "customer"

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending) #zero products is permitted as emptry hash, and can assume there is only 1 product
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    if !valid_status.include?(fulfillment_status)
      raise ArgumentError
    end
    @id = id
    @customer = customer
    @products = products
    @fulfillment_status = fulfillment_status
  end

  def total
    #price = products.values.sum
    #a note to mself -- products have keys and values and keys are banana, and values are the price
    #p products.key =>["banana", "cracker"]
    # p products.vales =>[1.99, 3.0]
    # p products.values.sum => 4.99
    # p [30, 20].sum => 50
    # to add tax, price + tax => price + (price * 0.075) for banana 1.9 + (1.99 * 0.075)
    total = products.values.sum
    tax = total * 0.075
    total_with_tax = total + tax
    return total_with_tax.round(2)
  end

  def add_product(product_name, price)
    # if hash[key]
    # puts "do something"
    # else
    # puts "do something else"
    # end
    if products[product_name]
      raise ArgumentError
    else
      products[product_name] = price
    end
  end

  def self.all
    order_instances = []

    CSV.open("data/orders.csv", "r").each do |data|
      id = data[0].to_i
      products = data[1]  # "Lobster:17.18;Annatto seed:58.38;Camomile:83.21"
      products_array = data[1].split(";") # ["Lobster:17.18", 'Annatto seed:58.38", "Camomile:83.21"]

      products_hash = {}

      products_array.each do |product_data| # "Lobster:17.18"
        product = product_data.split(":") # ["Lobster", "17.18"]
        product_name = product[0]
        product_price = product[1].to_f

        #hash[key] = value
        products_hash[product_name] = product_price
      end

      customer_id = data[2].to_i

      customer_instance = Customer.find(customer_id)

      status = data[3].to_sym

      order_instances << Order.new(id, products_hash, customer_instance, status)
    end
    return order_instances
  end

  def self.find(id)
    order_instances = self.all
    order_instance = order_instances.find do |order_instance|
      id == order_instance.id
    end

    return order_instance
  end
end




# AS IS
# order_instances.find do |order_instance|

#   if id == order_instance.id
#     return order_instance
#   end
# end


# TO BE
# order_instance = order_instances.find do |order_instance|
#   id == order_instance.id
# end

# return order_instance
# end

