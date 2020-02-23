#each class should get it's own file (eg. lib/class_name.rb)
#WAVE 1 (1)create a class, 2)write instance methods inside a class to perform actions, 3)use two classes using composition,
#4) use exceptions to hadle erros, 5) test

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end
end

# x = "hi"

# x = "hello"
# x = 'goodbye'

# customer = customer.new(id, email,delivery_address)
# fulfillment_status = fulfillment_status.new(:pending, :paid, :processing, :shipped, :complete)
# fulfillment_status = fulfillment_status(:pending)

# ben = Customer.new(10, 'ben@mail.com', {address})
# hannah = Customer.new(11, 'hannah')
# ben.orders
# hannah.orders
