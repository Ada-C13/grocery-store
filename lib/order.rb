class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError if !([:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status))
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    return 0 if @products.empty?

    total = @products.values.sum
    total += (0.075 * total)
    return total.round(2)
  end

  def add_product(new_product, price)
    raise ArgumentError if @products.include?(new_product)
    @products[new_product] = price
  end
end
