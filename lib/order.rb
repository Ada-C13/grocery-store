require_relative 'customer'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    valid_statuses = %i[pending paid processing shipped complete]
      if !valid_statuses.include?(@fulfillment_status)
        raise ArgumentError.new('Invalid status.')
      end
  end

  def total
    if @products == {}
      return 0
    else
      total = @products.values.reduce(:+) * 1.075

      return ('%.2f' % total).to_f
    end
  end

  def add_product(name, price)
    if @products.key?(name)
      raise ArgumentError.new('That product is already in the list.')
    else
      @products[name] = price
    end
  end

  def remove_product(name)
    if @products.key?(name)
      @products.delete(name)
    else
      raise ArgumentError.new('That product does not appear in the list.')
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
    Order.all.each do |order|
      return order if order.id == id
    end

    return nil
  end

  def self.find_by_customer(customer_id)
    customer_orders = []

    Order.all.each do |order|
      if order.customer.id == customer_id
        customer_orders << order
      end
    end

    return nil if customer_orders == []

    puts "Customer ##{customer_id} Order History"
    customer_orders.each do |order|
      puts "\nOrder ID: #{order.id}"
      puts "Status: #{order.fulfillment_status}"
      puts "Items in order: "
      order.products.each do |name, price|
        puts "  #{name} - #{price}"
      end
    end

  end
end