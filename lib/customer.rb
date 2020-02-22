require 'csv'


class Customer

  attr_reader :id
  attr_accessor :email, :address
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    all_customers = []
    filename = "./data/customers.csv"
    CSV.read(filename).each do |row|
      id = row[0].to_i
      email = row[1]
      address = {
        street: row[2],
        city: row[3],
        state: row[4],
        zip: row[5],
      }
      customer = Customer.new(id, email, address)
      all_customers << customer
    end
    return all_customers
  end

  def self.find(id)
    all_customers = Customer.all
    all_customers.each do |customer|
      if customer.id == id
        return customer
      end
    end
    return nil
  end

end
