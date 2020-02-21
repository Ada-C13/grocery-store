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
    raise ArgumentError.new("Product #{name} already exists.") if products.include? name
    products[name] = price
  end

  def remove_product(name)
    raise ArgumentError.new("Product #{name} does not exist.") unless products.include? name
    products.delete(name)
  end

  def self.format_products(products)
    products_in_order = {}
    products_array = products.split(";")
    products_array.each do |product|
      item = product.split(":")
      products_in_order[item[0]] = item[1].to_f.round(2)
    end
    return products_in_order
  end

  def self.all 
    all_orders = []

    CSV.read('./data/orders.csv').each do |line|
      products = format_products(line[1])
      all_orders << Order.new(line[0].to_i,products,Customer.new(line[2].to_i,"email","address"),line[3].to_sym)
    end
    return all_orders
  end



  def self.find(id)
  end


end