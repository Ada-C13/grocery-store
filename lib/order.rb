
class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id,products,customer,fulfillment_status=:pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    unless [:pending,:paid,:processing,:shipped,:complete].include?(@fulfillment_status)
      raise ArgumentError,'#{fulfillment_status} is not a valid input'
    end 
  end

  def total
    total_sum = @products.values.sum
    total_cost =  total_sum*(1.075)
    return  ('%.2f' % total_cost).to_f
  end 

  def add_product(name,price)
    unless @products.key?(name) == false 
      raise ArgumentError, '#{name} already exist in product list'
    end 
    @products[name] = price 
  end 

  def remove_product(name)
    unless @products.key?(name)
      raise ArgumentError, '#{name} is not in the product list'
    end 
    @products = @products.reject {|key,value| key == name}
  end 

end