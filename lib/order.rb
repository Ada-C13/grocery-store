require_relative 'customer.rb'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  @@OPTIONS = %i[pending paid processing shipped complete]

  def initialize(id, products, customer, fulfillment_status= :pending)
    @id =id
    @products = products
    @fulfillment_status = fulfillment_status
    @customer = customer
    unless @@OPTIONS.include? @fulfillment_status
      raise ArgumentError.new("This is not a valid fulfillment options")
    end
  end

  def total
    total = @products.values.sum + (@products.values.sum*0.075)
    return total.to_f.round(2)
  end

  def add_product(name, price)
    if @products.include? name
      raise ArgumentError.new("OH NO! There is already an item like that!!!")
    else
       @products[name] = price
    end
    return products
  end

  def remove_product(product_name)
    if products.keys.include? product_name
      products.delete(product_name)
    else
      raise ArgumentError.new("There is no such product!")
    end
  end

=begin
  def self.all 
    orders_data = CSV.read("./data/orders.csv") 
    orders = []
    orders_data.each do |order|
     orders << Order.new(order[0].to_i, order[1] order[2].to_i, fulfillment_status = order[3].to_sym )
    end
    return orders
  end
=end 
end