require_relative 'customer'

class Order
attr_reader :id, :customer 
attr_accessor :products, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status=:pending)
    @id = id
    @customer = customer 
    @products = products 
    if [:pending, :paid, :processing, :shipped, :complete].include?(fulfillment_status)
       @fulfillment_status = fulfillment_status
    else
      raise ArgumentError.new("Bogus status")
    end 
  end 

  def total
   
   if @products.length == 0 
      return 0.0
   end 
   total = 0
   @products.each do |product, price|
    total += price
   end 
   return ('%.2f' %(total * 1.075)).to_f
  end 

  def add_product(name, price)

    if @products.include?(name)
      raise ArgumentError.new("This product already present")
    else
      @products["#{name}"] = price 
    end 
  end 

  def remove_product(name)
    if @products.include?(name)
      @products.delete(name)
    else 
      raise ArgumentError.new("did not find that product")
    end 
  end
  def self.all
   array_of_orders = []
   arr = []
    CSV.foreach("../data/orders.csv") do |row|
      arr = row[1].split(";")
      #puts arr.to_s

      hash = arr.map do |product|
        [product.split(":")[0], product.split(":")[1].to_f]
      end 
      order_products = hash.to_h
      array_of_orders << Order.new(row[0].to_i, order_products, Customer.find(row[2]), row[3].to_sym)
    end 
   return array_of_orders
  end


  def self.find(id, function=:all)
      self.all.each do |order|
        if order.id.to_i == id.to_i
           return order
        end 
      end
      raise ArgumentError.new("Did not find order with this ID")
  end 


end 
def main
  
end 

main