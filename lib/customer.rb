require_relative 'order.rb'

class Customer 
    attr_reader :id
    attr_accessor :email,:address

  def initialize(id,email,address)
  @id = id 
  @email = email
  @address = {
  street: "",
  city: "",
  state: "",
  zip: "",
    }
  end 
end