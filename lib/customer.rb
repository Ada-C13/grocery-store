class Customer
  attr_accessor :email, :address
  attr_reader :id

  def initialize(id, email, address)
    @id = id
    @email = email if (email.class == String)
    @address = address if (address.class == Hash)
  end
end