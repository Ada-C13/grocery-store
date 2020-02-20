class Order 
  attr_reader :id, :customer, :products
  attr_accessor :fulfillment_status

  def initialize(id, products, customer, status = :pending)
    @id = id 
    @products = products
    @customer = customer
    @fulfillment_status = validate_status(status)

  end

  def validate_status(status)
    status_markers = %i[pending paid processing shipped complete]
    if status_markers.include? status
      return status.to_sym
    end
    raise ArgumentError.new("Invalid status given (#{status})")
  end

  def total 
    total = products.sum { |product, price| price }
    total *= 1.075
    total.round(2)
  end

  def add_product(name, price)
    raise ArgumentError.new("That product already exists.") if products.include? name
    products[name] = price
  end

end