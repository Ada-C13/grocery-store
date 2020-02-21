require_relative 'customer.rb'

class Order
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    case fulfillment_status
    when :pending, :paid , :processing , :shipped, :complete
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
    sum_of_products = products.values.sum.to_f
    plus_sales_tax = 1.075
    total_cost = (sum_of_products * plus_sales_tax)
    total_cost = total_cost.round(2)
    return total_cost
  end

  def add_product(product_name, price)
    product_name = product_name.to_s
    price = price.to_f.round(2)

    raise ArgumentError if @products.keys.include?(product_name)
    @products[product_name] = price
    return @products
  end

  def remove_product(product_name)
    if products.keys.include?(product_name)
      products.delete(product_name)
    else
      raise ArgumentError
    end
  end

  def self.all
    order_data = CSV.read('data/orders.csv')
    all_orders = Array.new

    order_data.each do |order|
      id = order[0].to_i

      products = Hash.new
      separate_order = order[1].split(";")
      separate_order.each do |indiv_prod|
        indiv_prod = indiv_prod.split(":")
        products[indiv_prod[0]] = indiv_prod[1].to_f
      end

      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym
      
      order_from_csv = Order.new(id, products, customer, fulfillment_status)
      all_orders << order_from_csv
    end
    return all_orders
  end

  def self.find(id)
    all_orders = Order.all
    order_w_id = 0
    all_orders.each do |order|
      if order.id == id
        order_w_id = order
      end
    end
    
    return order_w_id unless order_w_id == 0
  end

  def self.find_by_customer(customer_id)
    order_w_customer_id = 0
    all_order_from_customer = Array.new
    self.all.each do |order|
      if order.customer.id == customer_id
        order_w_customer_id = order
        all_order_from_customer << order_w_customer_id
      end
    end
    
    return all_order_from_customer unless all_order_from_customer.empty?
  end
end

puts Order.find_by_customer(25)
