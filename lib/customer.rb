require 'csv'

class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email if (email.class == String)
    @address = address if (address.class == Hash)
  end

  def self.all
    customer_array = CSV.read("data/customers.csv", headers: true).map do |row|
      Customer.new( 
        row["ID"].to_i,
        row["Email"],
        {
          street: row["Address"],
          city: row["City"],
          state: row["State"],
          zip: row["Zip"]
        }
      )
    end
    return customer_array
  end
  
  def self.find(id)
    #returns a customer for whom the id passed as an argument is the same as its own id.
    self.all.find { |customer| customer.id == id }
    # if cust_id == nil
    #   return ArgumentError, "The id #{id} does not belong to any of these customers."
    # else
    #   return cust_id
    # end
  end
end