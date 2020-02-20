class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    if [:pending, :paid, :processing, :shipped, :complete].include? fulfillment_status
      @fulfillment_status = fulfillment_status
    else 
      raise ArgumentError.new("That is not a valid fulfillment status.")
    end
  end

  def total
    sum = products.values.sum
    tax = sum * 0.075
    sum += tax
    return sum.round(2)
  end

  def add_product(name, price)
  end

end