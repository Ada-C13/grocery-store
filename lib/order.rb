class Order
  attr_reader :id
  attr_accessor :products, :fulfillment_status, :customer

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id #integer
    @products = products #hash
    @customer = customer #instance of customer
    @fulfillment_status = fulfillment_status
    unless @fulfillment_status == :pending || @fulfillment_status == :paid || @fulfillment_status == :processing || @fulfillment_status == :shipped || @fulfillment_status == :complete
      raise ArgumentError, "The status is invalid"
    end
  end

  def total
    price = 0
    @products.each do |product, cost|
      price += cost
    end
      price *= 1.075
    return price.round(2)
  end

  def add_product(product_name, price)
    if @products.keys.include? product_name
      raise ArgumentError, "Such product already exists in the list"
    else
      @products[product_name] = price
    end
    return @products
  end

  def remove(product_name)
    unless @products.keys.include? product_name
      raise ArgumentError, "There is no such product in the list"
    else
      @products.delete(product_name)
    end
    return @products
  end
end