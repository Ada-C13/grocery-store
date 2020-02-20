class Order
  attr_reader :id
  attr_accessor :products_collection

  def initialize(id, products_collection, customer, fulfillment_status = :pending)
    @id = id
    @products_collection = products_collection
    @customer = customer
    statuses = [:pending, :paid, :shipped, :complete]
    if !statuses.include? fulfillment_status
      raise ArgumentError.new
    end
    @fulfillment_status = fulfillment_status
  end

  def total()
    sum = 0
    @products_collection.each do |product, cost|
      sum += cost
    end

    sum_with_tax = (sum + (sum * 0.075)).round(2)

    return sum_with_tax
  end

  def add_product(product_name, price)
    if @products_collection.has_key?(product_name)
      raise ArgumentError.new("This product is already in the collection.")
    end

    @products_collection[product_name] = price
  end
end


