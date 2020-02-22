require_relative "customer"

class Order
  attr_reader :id, :customer
  attr_accessor :products, :fulfillment_status
  # (num, hash, instance of customer, symbol)

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    status_lists = [:pending, :paid, :processing, :shipped, :complete]
    # If a status is given that is not one of the above, an ArgumentError should be raised
    raise ArgumentError.new ("There's no such status!") if !status_lists.any? (fulfillment_status)
    return 0 if @products.empty?
  end

  def total # hash
    if @products.empty?
      return 0
    else
    total_cost = (@products.values.inject{ |sum, price| sum + price} * 1.075).round(2) 
    # Adding a 7.5% tax and round it to two deciamal places
    return total_cost
    end
  end

  def add_product(name, price) # (string, num)
    if products.keys.any? (name)
      raise ArgumentError.new ("There's a duplicate!")  
    else 
      @products[name] = price
    end
  end



end


# amy = Customer.new(123, "amy@ada.com", {
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# })
# p amy

# p a = Order.new(1, {"apple" => 1.5, "banana" => 3.0}, amy)
# p a
# p a.add_product("apple", 1.3)




# raise ArgumentError.new ("There's no such status") if fulfillment_status != :pending && fulfillment_status != :paid && fulfillment_status != :processing && fulfillment_status != :shipped && fulfillment_status != :complete