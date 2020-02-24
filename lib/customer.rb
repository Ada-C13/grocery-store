require 'csv'


class Customer 

    attr_reader :id
    attr_accessor :email, :address

    def initialize(id,email,address)
        @id = id
        @email = email
        @address = address
    end

    def self.all 
        
        customer_list = []
        CSV.foreach("data/customers.csv") do |customer|
        #CSV.foreach("path/to/file.csv", **options) do |row|
            address = {}
            id= customer[0].to_i
            email= customer[1]
            address[:street] = customer[2]
            address[:city] = customer[3]
            address[:state] = customer[4]
            address[:zip] = customer[5]
            c = Customer.new(id,email,address)
            customer_list.push c
        end
        return customer_list
    end

    def self.find(x)
    #returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
        list = Customer.all
        list.each do |customer|
            # puts x
            # puts x.class
            # puts customer.id
            # puts customer.id.class
            if customer.id == x 
                return customer
            end
        end 
        return nil 
    end
   
def save(filename,customer)
    CSV.open(filename, "wb") do |csv|  
        row = [customer.id,customer.email,customer.address]
        cvs << row 
    end  
    return true
end

hala = Customer.new(1,"h.m.haddad@gmail.com",{"street": "13258 124th","city": "kirkland","state": "wa","zip": "98034"})
puts save("data/new_customers.csv",hala)

end 

