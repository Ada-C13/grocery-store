class Order 

  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)

    statuses = [:pending, :paid, :processing, :shipped, :complete]

    # If a status is given that is not one of the above, an ArgumentError should be raised
    if !statuses.include?(fulfillment_status)
      raise ArgumentError.new("#{fulfillment_status} is not valid. Please enter a valid status.")
    end 


    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end 

  def total
    sum = @products.values.sum

    return 0 if sum == 0 

    tax = sum * 0.075  # 7.5%
    total_price = sum + tax

    return total_price.round(2)
  end 


  def add_product(product_name, price) 
    if @products[product_name]
      raise ArgumentError.new("The product, #{product_name} has already added to the order.")
    else 
      @products[product_name] = price
    end 
  end 

  def remove_product(product_name) 
    if @products[product_name]
      @products.delete(product_name)
    else 
      raise ArgumentError.new("The product, #{product_name} was not found in the order system.")
    end 
  end 
end 