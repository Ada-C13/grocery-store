class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    valid_statuses = [:pending, :paid, :processing, :shipped, :complete]
    if !valid_statuses.include? fulfillment_status
      raise ArgumentError.new("Invalid status")
    end
    @fulfillment_status = fulfillment_status
  end

  def total()
    sum = 0
    @products.each do |product, cost|
      sum += cost
    end

    sum_with_tax = (sum + (sum * 0.075)).round(2)

    return sum_with_tax
  end

  def add_product(product_name, price)
    if @products.has_key?(product_name)
      raise ArgumentError.new("This product is already in the collection.")
    end

    @products[product_name] = price
  end
end


