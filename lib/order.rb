class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses = %i[pending paid processing shipped complete]
      raise ArgumentError if !valid_statuses.include?(@fulfillment_status)
  end

  def total
    if @products == {}
      return 0
    else
      total = @products.values.reduce(:+)
      total = total + (total * 0.075)

      return ('%.2f' % total).to_f
    end
  end

  def add_product(name, price)
    if @products.key?(name)
      raise ArgumentError
    else
      @products[name] = price
    end
  end
end