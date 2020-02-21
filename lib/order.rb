require_relative 'order.rb'

class Order
    attr_reader :id

def initialize(id)
    @id = id 
end 

def total
# Summing up the products
# Adding a 7.5% tax
# Rounding the result to two decimal places
end

def fufillment_status(pending:, paid:, processing:, shipped:, complete:)
    raise ArgumentError if fufillment_status 
end 
end