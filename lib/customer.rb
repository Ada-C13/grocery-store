class Customer
  # Wave 1
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id.to_i
    @email = email
    @address = address
  end


  # returns a collection of Customer instances, 
  # representing all of the Customer described in the CSV file
  def self.all
    customers_csv = CSV.read("./data/customers.csv")

    customers = customers_csv.map do |customer_row|
      Customer.new(customer_row[0], customer_row[1],
      { :street => customer_row[2],
        :city => customer_row[3],
        :state => customer_row[4],
        :zip => customer_row[5]
      })
    end

    return customers

  end

  # returns an instance of Customer where the value of the 
  # id field in the CSV matches the passed parameter
  def self.find(id)
    customers = Customer.all
    found_customer = customers.detect {|customer| (customer.id) == id}
    return found_customer
  end

end