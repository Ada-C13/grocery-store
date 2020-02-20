class Order

  attr_accessor :customer, :fulfillment_status
  attr_reader :id

  def initialize(id, products_hash = {}, customer, fulfillment_status)
    @id = id
    @customer = customer
    @products_hash = products_hash
    @fulfillment_status = fulfillment_status
  end

  def total
    sum = @products_hash.values.sum
    sum *= 1.075
    return sum.round(2)
  end

  def add_product(product_name, price)
    if @products_hash.keys.include?(product_name)
      @products_hash[:product_name] = price 
    else
      raise ArgumentError, "The product '#{product_name}' is already in this collection."
    end
  end
end