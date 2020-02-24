require 'csv'


class Customer

  attr_reader :id
  attr_accessor :email, :address 

  def initialize(id, email, address = "customer")
    @id = id
    @email = email
    @address = address
  end

  def self.all
    csv_customers = CSV.read('data/customers.csv')
    customers = []
      csv_customers.each do |row|
        id = row[0].to_i
        email = row[1]
        address = {
          :street => row[2],
          :city => row[3],
          :state => row[4],
          :zip => row[5]
        }
        customers.push(Customer.new(id,email, address))
      end 
    return customers
  end

  def self.find(id)
    Customer.all.each do |customer|
      if customer.id == id
        return customer
      end 
    end
    return nil
  end 
end
