#Wave 1
# Create a class called Customer

class Customer
  attr_reader :id 
  attr_accessor :email, :address
  
  def initialize(id, email, address = {})
    @id = id
    @email = email
    @address = address
  end

end