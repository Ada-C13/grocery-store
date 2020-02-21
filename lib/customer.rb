
class Customer

  attr_reader :id
  attr_accessor :email, :address
  @@number_of_customers = 0

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
    # @order = order
    # @order.customer_info(self)
  end

  # Method to access to all the customers.
  def self.all
    return @@number_of_customers
  end
end

# nw = Customer.new(123,"ll@gmail.com",{
#   street: "123 Main",
#   city: "Seattle",
#   state: "WA",
#   zip: "98101"
# })

# p nw