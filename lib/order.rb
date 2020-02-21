#Create a class called Order
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id,products, customer,fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses =  [:pending, :paid, :processing, :shipped,:complete]
    unless valid_statuses.include?(fulfillment_status)
    raise ArgumentError, 'you have provided an invalied choice'
    end
    
  end
end
