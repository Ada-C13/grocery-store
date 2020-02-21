require "csv"

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address = {})
    @id = id
    @email = email
    @address = address
  end

  def self.all
    # returns a collection of Customer instances, representing all of the Customer described in the CSV
  end

  def self.find(id)
    # returns an instance of Customer where the value of the id field in the CSV matches the passed parameter
    # should not parse the CSV file itself. Instead it should invoke Customer.all and search through the results for a customer with a matching ID
    # What should your program do if Customer.find is called with an ID that doesn't exist? Hint: what does the find method for a Ruby array do?
    # https://ruby-doc.org/core/Enumerable.html#method-i-find
  end
end
