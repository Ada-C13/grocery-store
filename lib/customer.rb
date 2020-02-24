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

    CSV.read('./data/customers.csv').each do |line|
      address_headers = ["street", "city", "state", "zip"]
      address_chunks = line[2..5]
      address_hash = Hash[address_headers.map(&:to_sym).zip(address_chunks)]

      all_customers << Customer.new(line[0].to_i,line[1],address_hash)
    end
    return all_customers
  end

  def self.find(id)
    all_customers = self.all
    all_customers.find { |customer| customer.id == id }
  end

end 