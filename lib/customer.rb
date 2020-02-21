require 'csv'

class Customer
 attr_reader :id, :email, :address
 attr_writer :email, :address
  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end  

  
  def self.all
    customers = []
    CSV.read('./data/customers.csv').each do |customer|
      customers << Customer.new(customer[0].to_i, customer[1], {:street =>customer[2],:city =>customer[3],:state =>customer[4],:zip =>customer[5]})
    end
    return customers
  end

  def self.find(id)
    Customer.all.each do |custumer|
      if custumer.id  == id
        return custumer
      end
    end
    return nil
  end

end