class Customer
  
  attr_reader :id
  attr_accessor :email, :address 

  def initialize(id, email, address)
    @id = id # this is an integer
    @email = email # this is a string
    @address = address # this is a hash
  end

end