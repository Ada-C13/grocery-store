#Create a class called Order
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses =  [:pending, :paid, :processing, :shipped,:complete]
    unless valid_statuses.include?(fulfillment_status)
    raise ArgumentError, 'you have provided an invalied choice'
    end 
  end

  # Create a total method
  def total
   all_costs = products.map do |product, cost|
      cost
   end 
   sum_costs = all_costs.sum
   total = (sum_costs + sum_costs * 0.075).round(2)
   return total
  end


# Create add_product method 
  def add_product(product_name, price)
    # get all the names of product from products hash
    raise ArgumentError if products.key?(product_name)
    @products[product_name] = price
    return @products
  end
end





  
