
require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
    # @order = order
    # @order.customer_info(self)
  end

  # Method to access to all the customers.
  def self.all
    # File path.
    file = 'data/customers.csv'
    data = CSV.read(file)
    # An array to save all the customers
    customers = Array.new
    # data is an array data structure.
    for index in (0...data.length)
    # Addrees hash
    address = {
        :street => data[index][2],
        :city => data[index][3],
        :state => data[index][4],
        :zip => data[index][5]
      }
    # Every custumer create a new instance, parameter:
    # id place [0], email place[1], address hash.
    customers << Customer.new(data[index][0].to_i,data[index][1],address)
    end
  return customers
  end
  
  def self.find(id)
    customers_info = Customer.all
    customers_info.select do |customer|
      if customer.id == id
        return Customer.new(customer.id, customer.email,customer.address)
      end
    end
  return nil
  end
end
