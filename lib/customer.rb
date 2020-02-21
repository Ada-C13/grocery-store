require 'csv'


class Customer
  attr_reader :id
  attr_accessor :email ,:address

    def initialize(id,email,address)
      @id = id
      @email = email
      @address = address 
      
    end

    def self.all
      dictionary_path = File.join(File.dirname(__FILE__),"../data/customers.csv")
      keys = [:id,:email,:address,:city,:state,:zip]
      data = CSV.read(dictionary_path) 
      data_with_header = data.map {|array| Hash[keys.zip(array)]}
      customer_test = data_with_header.map {|hash| hash.slice(:id,:email,:address)}
      p customer_test.class 
      p customer_test[0]
    end 

end 