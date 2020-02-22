require 'csv'

order_data = CSV.read('./data/orders.csv')

input = order_data[0][1]

def parse_products(input)
  product_hash = {} # thing to return

  first_split = input.split(';') 
  # given 
  # returns an array ["Amaranth:83.81, "Smoked Trout:70.6"]
  
  first_split.each do |product|
    final_split = product.split(':')
    name = final_split[0]
    price = final_split[1]
    product_hash[final_split[0]] = final_split[1]
  end

  return product_hash
  # output = correctly formatted hash of products for that order
end

print parse_products(input)