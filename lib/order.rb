class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending) #zero products is permitted as emptry hash, and can assume there is only 1 product
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    if !valid_status.include?(fulfillment_status)
      raise ArgumentError
    end
    @id = id
    @customer = customer
    @products = products
    @fulfillment_status = fulfillment_status
  end

  def total
    #price = products.values.sum
    #a note to mself -- products have keys and values and keys are banana, and values are the price
    #p products.key =>["banana", "cracker"]
    # p products.vales =>[1.99, 3.0]
    # p products.values.sum => 4.99
    # p [30, 20].sum => 50
    # to add tax, price + tax => price + (price * 0.075) for banana 1.9 + (1.99 * 0.075)
    total = products.values.sum
    tax = total * 0.075
    total_with_tax = total + tax
    return total_with_tax.round(2)
  end

  def add_product(product_name, price)
    # if hash[key]
    # puts "do something"
    # else
    # puts "do something else"
    # end
    if products[product_name]
      raise ArgumentError
    else
      products[product_name] = price
    end
  end
end

# Order.new(1,{}, ben, :error) # ArgumentError
