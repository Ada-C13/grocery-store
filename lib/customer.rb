require 'csv'


class Customer
  attr_reader :id
  attr_accessor :email ,:address

    def initialize(id,email,address)
      @id = id
      @email = email
      @address = address 
      
    end

    def set_customer_id(customer_id)
      @id = customer_id
    end 


    def self.all
      dictionary_path = File.join(File.dirname(__FILE__),"../data/customers.csv")
      data = CSV.read(dictionary_path) 
      list = []
      data.each do |line|
        hash_temp = {:street => line[2], :city => line[3], :state => line[4], :zip => line[5]}
        list << Customer.new(line[0].to_i,line[1],hash_temp)
      end 
      return list
    end 

    def self.find(id)
      data = Customer.all
      data.each do |line|
        if line.id == id 
          return line
        end 
      end 
      return nil
    end 


end 


