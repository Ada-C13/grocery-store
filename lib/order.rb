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
  
  def parse_products
    # make this operate on an individual order's string
    orders = CSV.read('./data/orders.csv')
    products = {}
    
    orders.each do |order|
      split_food_price = ""
      
      squished_food_price = order[1].split(';')
      
      squished_food_price.each do |item_with_price|
        split_food_price = item_with_price.split(':')
        name = split_food_price[0]
        price = split_food_price[1].to_f
        products[name] = price
      end
      
    end
    
    return products
  end
  
  #what the fuck does this actually return??
  #and is it doing what we want? maybe not!
  
  
  # TODO Order.all calls Customer.find to set up the composition relation
  def self.all
    orders = CSV.read('./data/orders.csv')
    
    all_orders = []
    new_order = ""
    
    orders.each do |order|
      id = order[0]
      products = parse_products
      # tim is great!
      # we want to take order[1] and invoke the parse_products method ON IT IN HERE
      customer = order[2] # this actually should be connected to the customer object associated with the ID
      fulfillment_status = order[3]
      
      new_order = Order.new(id, products, customer, fulfillment_status)
      
      all_orders << new_order
    end
    
    return all_orders
  end
  
  def self.find(id)
    # returns a single instance of order object where value of id matches passed id
    # use order.all (not the CSV data)
  end
end
