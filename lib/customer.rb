class Customer
  attr_reader :id
  attr_accessor :email_address, :delivery_address

  def initialize(id, email, delivery_address)
    @id = id #integer
    @email_address = email_address #string
    @delivery_address = delivery_address #hash
  end
end