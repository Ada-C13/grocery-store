require "csv"
require_relative "order"

class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  # Class Method: returns an array of all the customer instances from the CSV file. loads the data when this class method is called
  def self.all
    instances_array = CSV.read("./data/customers.csv").map do |row| #relative path based on rake file/ running file
      Customer.new(row[0].to_i, row[1], {:street => row[2], :city => row[3], :state => row[4], :zip => row[5]})
    end   
    
    return instances_array
  end

  # Class Method: find customer instance via customer id
  def self.find(id)
    self.all.each do |customer|
      if customer.id == id
        return customer
      end
    end

    return nil
  end

  # Class Method: write new customer instance into a CSV file
  def self.save(filename, new_customer) #filename could be "./data/new_customer_list.csv"
    CSV.open(filename, "a") do |csv|
      csv << [new_customer.id.to_s, new_customer.email, new_customer.address[:street], new_customer.address[:city],new_customer.address[:state], new_customer.address[:zip]]
    end

    return true
  end
end