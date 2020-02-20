class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    # raise ArgumentError if !([:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status))
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end
end
