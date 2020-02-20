class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id = 0, email = '', address = {})
    @id = id
    @email = email
    @address = address
  end

end