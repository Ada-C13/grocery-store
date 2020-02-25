#each class should get it's own file (eg. lib/class_name.rb)
#WAVE 1 (1)create a class, 2)write instance methods inside a class to perform actions, 3)use two classes using composition,
#4) use exceptions to hadle erros, 5) test
require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customer_instances = []
    CSV.readlines("data/customers.csv", "r").each do |data|
      #   print data[0]
      id = data[0]
      email = data[1]
      address = {
        :street => data[2],
        :city => data[3],
        :state => data[4],
        :zip => data[5],
      }
      customer_instances << Customer.new(id.to_i, email, address)
    end
    return customer_instances
  end

  def self.find(id)
    customer_instances = self.all #array of cxs
    customer_instances.find do |customer_instance|
      # <meta data> = customer_instances.id
      if id == customer_instance.id
        return customer_instance
      end
    end
  end
end
