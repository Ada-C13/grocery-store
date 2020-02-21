require 'smarter_csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = []
    CSV.open('data/customers.csv', 'r').each do |line|
      read_customer = Customer.new(line[0].to_i, line[1], {:street => line[2], :city => line[3], :state => line[4], :zip => line[5]})
      customers.push(read_customer)

    end
    return customers
  end
  #return customers

  def self.find(id)
    
  end
end

# customers = SmarterCSV.process(
#   '../data/customers.csv',
#   {
#     headers_in_file: false,
#     user_provided_headers: %i[id email street city state zip],
#     remove_empty_values: false,
#     remove_zero_values: false,
#   }
# )

# p customers.first
# p customers.last