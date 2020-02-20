# require_relative 'order'

class Customer
  
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id,email,address)
    @id = id # a number
    @email = email # a string
    @address = address # a hash
  end

end