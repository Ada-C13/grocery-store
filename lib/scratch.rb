def self.all
  orders = []
  CSV.read("./data/orders.csv").each do |order|
    id = order[0].to_i
    products = {}
    first_time_splitted_string = order[1].split(";")
    first_time_splitted_string.each do |element|
      second_time_splitted_string = element.split(":")
      products[second_time_splitted_string[0]] = second_time_splitted_string[1].to_f
    end
    customer = Customer.find(order[2].to_i)
    fulfillment_status = order[3].to_sym
    orders << Order.new(id, products, customer, fulfillment_status)
  end
  return orders
end
