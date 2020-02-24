class Customer 
  require 'csv'
  
  attr_reader :id 
  attr_accessor :email, :address
  
  def initialize(id, email, address)
    @id = id.to_i
    @email = email 
    @address = address
  end
  
  def self.all
    customers_csv = CSV.read("./data/customers.csv")
    customers = customers_csv.map do |customer_row|
      Customer.new(customer_row[0], customer_row[1],
        {:street => customer_row[2],
          :city => customer_row[3],
          :state => customer_row[4],
          :zip => customer_row[5]
          })
    end
    return customers
  end

  def self.find(id)
    return (self.all).bsearch { |customer| id <=> customer.id }
  end
      
end 