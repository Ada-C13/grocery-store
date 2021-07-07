require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    data = CSV.read("./data/customers.csv")
    customer_info = []

    data.each do |row|
      id = row[0].to_i
      email = row[1]
      address = {}
      address[:street] = row[2]
      address[:city] = row[3]
      address[:state] = row[4]
      address[:zip] = row[5]
      
      customer = Customer.new(id, email, address)
      customer_info << customer
    end

    return customer_info
  end

  def self.find(id)
    customer_info = self.all
    customer_with_id = customer_info.find { |customer| customer.id == id}
    return customer_with_id
  end
end