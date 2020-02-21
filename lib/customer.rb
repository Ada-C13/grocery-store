require_relative 'order.rb'
require 'csv'
require 'awesome_print'

class Customer
  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers.csv = CSV.read(data / customers.csv)
  end

  def self.find(id); end
end
