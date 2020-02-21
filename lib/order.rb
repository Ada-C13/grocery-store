class Order
  attr_reader :id, :products, :customer, :fulfillment_status
  attr_writer :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    case fulfillment_status 
    when :pending, :paid, :processing, :shipped, :complete
      @fulfillment_status = fulfillment_status
    else
      raise ArgumentError
    end

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end 

  def total
    total_value = @products.values.sum
    total_value_tax = (total_value * 1.075)
    total_value_tax = total_value_tax.round(2)
    return total_value_tax
  end


  def add_product(name, price)

    if @products.key?(name)
      raise ArgumentError
    else
      @products[name] = price
      return @products
    end  

  end
end



 