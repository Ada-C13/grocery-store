require_relative 'customer'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  def initialize(id, products, customer, fulfillment_status = :pending)
    raise ArgumentError unless %i[pending paid processing shipped complete].include?(fulfillment_status)

    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
  end

  def total
    product_total = @products.values.sum
    tax = ( product_total * 7.50 ) / 100
    total = (product_total + tax)
    return ('%.2f' % total).to_f
  end

  def add_product(product_name, price)
    raise ArgumentError if @products.keys.include?(product_name)
    @products[product_name] = price
  end

  # def remove_product(product_name)
  #   raise ArgumentError if @products.keys.include?(product_name) == false
  #   @products.delete_if {|key, value| key >= product_name } 
  # end

  def self.all
    all_orders = []
    filename = "./data/orders.csv"
    CSV.read(filename).each do |row|
      id = row[0].to_i
      products ={}
      products_string = row[1].split(';')
      products_string.each do |product|
        product_split = product.split(':')
        products[product_split[0]] = product_split[1].to_f
      end
      customer = Customer.find(row[2].to_i)
      fulfillment_status = row[3].to_sym
      order = Order.new(id, products, customer, fulfillment_status)
      all_orders << order
    end
    return all_orders
  end

  def self.find(id)
    all_orders = Order.all
    all_orders.each do |order|
      if order.id == id
        return order
      end
    end
    return nil
  end

  # # Order.find_by_customer(customer_id) - returns a list of Order instances where the value of the customer's ID matches the passed parameter.
  # def self.find_by_customer(customer_id)
  #   all_orders = Order.all
  #   customer_orders = []
  #   all_orders.each do |order|
  #     if order.customer == customer_id
  #       customer_orders << order
  #     end
  #   end
  #   if all_orders.map{ |order| order.customer}.include?(customer_id) == false
  #     return nil
  #   end
  #   return customer_orders
  # end

end