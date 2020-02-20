class Order
  attr_reader :id
  attr_accessor :products_and_costs, :fulfillment_status, :customer

  def initialize(id, products_and_costs, customer, fulfillment_status = :pending)
    @id = id #integer
    @products_and_costs = products_and_costs #hash
    @customer = customer #instance of customer
    if fulfillment_status != :paid && fulfillment_status != :processing && fulfillment_status != :shipped && fulfillment_status != :complete
      raise ArgumentError, "The status is invalid"
    end
    @fulfillment_status = fulfillment_status
  end

  def total
    price = 0
    @products_and_costs.each do |product, cost|
      price += cost
    end
      price *= 1.075
    return price.round(2)
  end

  def add_product(product_name, price)
    if @products_and_costs.keys.include? product_name
      raise ArgumentError, "Such product already exists in the list"
    else
      @products_and_costs[product_name] = price
    end
    return @products_and_costs
  end

  def remove(product_name)
    unless @products_and_costs.keys.include? product_name
      raise ArgumentError, "There is no such product in the list"
    else
      @products_and_costs.delete(product_name)
    end
    return @products_and_costs
  end
end