class Order
  
  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status
  
  
  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status
    
    valid_status = [:pending, :paid, :processing, :shipped, :complete]
    
    if !(valid_status.include?(@fulfillment_status))
      raise(ArgumentError, "Invalid fulfillment status")
    end
  end
  
  def total
    total = (@products.values.sum) * 1.075
    return total.round(2)
  end
  
  def add_product(name, price)
    @name = name # this is a key
    @price = price # this is that key's value
    
    if @products.keys.include? name
      raise(ArgumentError, "This product is already included in this order!")
    else @products[name] = price
    end
  end
  
  def self.parse_products(input)
    product_hash = {}
    
    first_split = input.split(';') 
    
    first_split.each do |product|
      final_split = product.split(':')
      name = final_split[0]
      price = final_split[1].to_f
      product_hash[name] = price
    end
    
    return product_hash
  end
  
  #what the fuck does this actually return??
  #and is it doing what we want? maybe not!
  
  
  def self.all
    orders = CSV.read('./data/orders.csv')
    
    all_orders = []
    new_order = ""
    
    orders.each do |order|
      id = order[0].to_i
      products = parse_products(order[1])
      customer = Customer.find(order[2].to_i)
      fulfillment_status = order[3].to_sym
      
      new_order = Order.new(id, products, customer, fulfillment_status)
      
      all_orders << new_order
    end
    
    return all_orders
  end
  
  def self.find(id)
    # returns a single instance of order object where value of id matches passed id
    # use order.all (not the CSV data)
    all_orders = self.all
    
    found_orders_array = all_orders.select { |order| order.id == id }
    
    if found_orders_array.empty?
      return nil
    else
      found_order = found_orders_array[0]
    end
    return found_order
  end
  
end