class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError unless %i[pending paid processing shipped complete].include?(fulfillment_status)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
   total = 0
    @products.each do |key, value|
      total += value
    end
    total += total * 0.075
    total = ('%.2f' % total).to_f
    return total
  end

  def add_product(name, price)
      raise ArgumentError if @products.has_key?(name)
      products[name] = price
  end

end