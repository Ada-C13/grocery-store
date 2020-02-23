require 'csv'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  @@all_customers = []

  def initialize(id, email, address = {})
    @id = id
    @email = email
    @address = address
  end

  def self.customer_data
    if @@all_customers.length != 0
      return
    end
    CSV.read('./data/customers.csv').each do |customer_info|

      customer_id = customer_info[0].to_i
      customer_email = "#{customer_info[1]}"

      address_hash = {}
      address_hash[:street] = "#{customer_info[2]}"
      address_hash[:city] = "#{customer_info[3]}"
      address_hash[:state] = "#{customer_info[4]}"
      address_hash[:zip] = customer_info[5]

      @@all_customers << Customer.new(customer_id,customer_email,address_hash)
    end
  end

  def self.all
    self.customer_data
    return @@all_customers
  end

  def self.find(id)
    all_customers = self.all
    all_customers.each do |customer|
      if customer.id == id
        return customer
      elsif 
        nil
      end
    end
  end
end

Customer.find(1)