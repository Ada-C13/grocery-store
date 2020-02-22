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
    customer_data = CSV.read('data/customers.csv')
    all_customers = Array.new
    customer_data.each do |customer|
      address = Hash.new
      id = customer[0].to_i
      email = customer[1].to_s
      address[:street] = customer[2]
      address[:city] = customer[3]
      address[:state] = customer[4]
      address[:zip] = customer[5]
      customer_from_csv = Customer.new(id, email, address)
      all_customers << customer_from_csv
    end
    return all_customers
  end
 
  def self.find(id)
    all_customers = Customer.all
    customer_w_id = 0
    all_customers.each do |customer|
      if customer.id == id
        customer_w_id = customer
      end
    end
    
    return customer_w_id unless customer_w_id == 0
  end

end
