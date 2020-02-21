class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses = %i[pending paid processing shipped complete]
      raise ArgumentError if !valid_statuses.include?(@fulfillment_status)
  end

  def total
    if @products == {}
      return 0
    else
      total = @products.values.reduce(:+)
      total = total * 1.075

      return ('%.2f' % total).to_f
    end
  end

  def add_product(name, price)
    if @products.key?(name)
      raise ArgumentError
    else
      @products[name] = price
    end
  end

  def self.all
    all_orders = []

    CSV.read('data/orders.csv').each do |order|
      products_hash = {}
  
      id = order[0].to_i
      products = order[1].split(';')
      products.each do |product|
        products_array = product.split(':')
        products_hash[products_array[0]] = products_array[1].to_f
      end

      customer = Customer.find(order[2].to_i)
      status = order[3].to_sym

      all_orders << Order.new(id, products_hash, customer, status)
    end
    
    return all_orders
  end

  def self.find(id)

  end
end