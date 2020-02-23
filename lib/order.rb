class Order
  # id is only reader
  attr_reader :id, :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    status = [:pending, :paid, :processing, :shipped, :complete]

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    # if a status is given that is not one of the above, an ArgumentError should be raised
    unless status.include?(@fulfillment_status)
      return raise ArgumentError, "Invalid Entry."
    end
  end

  # add a total method

  def total
    product_total = 0
    tax = 1.075
    @products.each do |product, price|
      product_total += price
    end
    order_total = (product_total * tax).round(2)
    return order_total
  end

  ###########
  # add add_product method
  def add_product(product_name, price)
    if @products.key?(product_name)
      raise ArgumentError.new "Added product already exists"
    else
      @products[product_name] = price
    end
    return @products
  end

  # add remove_product
  def remove_product(product_name)
    if @products.key?(product_name)
      @products.delete(product_name)
    else
      raise ArgumentError.new "Deleted product doesn't exist"
    end
    return @products
  end

  # wave 2
  def self.all
    all_orders = []

    CSV.read("data/orders.csv").each do |order|
      id = order[0].to_i
      products = {}
      @item_price_array = order[1].split(";")

      # parse through product by item/price
      @item_price_array.each do |product|
        split_product = product.split(":")
        item = split_product[0]
        price = split_product[1].to_f
        products_hash = { item => price }
        products.merge!(products_hash)
      end
      # turn the customer ID into an instance of Customer
      customer = Customer.find(order[2].to_i)
      status = order[3].to_sym
      all_orders << Order.new(id.to_i, products, customer, status)
    end
    return all_orders
  end

  def self.find(id)
    self.all.each do |order|
      if id == order.id
        return order
      end
    end
    return nil
  end
end
