class Order
  # Constants for fulfillment status
  VALID_STATUS = [:pending, :paid, :processing, :shipped, :complete]
  
  # Attributes
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    
    # Check on fulfillment status
    unless VALID_STATUS.include?(@fulfillment_status)
      raise ArgumentError, "Fulfillment status not valid"
    end
  end
  
  # Find total cost for products 
  def total
    if @products.empty?
      return 0
    end
    total_cost = @products.values.sum
    total_cost += (total_cost * 0.075).round(2)
    return total_cost
  end
  
  # Add a new product to the products hash
  def add_product(product_name, product_price)
    if @products.keys.include?(product_name)
      raise ArgumentError, "Something went wrong."
    end
    @products["#{product_name}"] = product_price
  end

end