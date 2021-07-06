require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/customer'
require 'csv'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Customer Wave 1" do
  ID = 123
  EMAIL = "a@a.co"
  ADDRESS = {
    street: "123 Main",
    city: "Seattle",
    state: "WA",
    zip: "98101"
  }.freeze

  describe "#initialize" do
    it "Takes an ID, email and address info" do
      cust = Customer.new(ID, EMAIL, ADDRESS)

      expect(cust).must_respond_to :id
      expect(cust.id).must_equal ID

      expect(cust).must_respond_to :email
      expect(cust.email).must_equal EMAIL

      expect(cust).must_respond_to :address
      expect(cust.address).must_equal ADDRESS
    end
  end
end

# TODO: remove the 'x' in front of this block when you start wave 2
describe "Customer Wave 2" do
  describe "Customer.all" do
    it "Returns an array of all customers" do
      customers = Customer.all
      num_of_customers = CSV.read("data/customers.csv").length

      # Changed from 35 to "actual number of customers" from CSV since I added "Customer.save" method
      expect(customers.length).must_equal num_of_customers

      customers.each do |c|
        expect(c).must_be_kind_of Customer

        expect(c.id).must_be_kind_of Integer
        expect(c.email).must_be_kind_of String
        expect(c.address).must_be_kind_of Hash
      end
    end

    it "Returns accurate information about the first customer" do
      first = Customer.all.first

      expect(first.id).must_equal 1
      expect(first.email).must_equal "leonard.rogahn@hagenes.org"
      expect(first.address[:street]).must_equal "71596 Eden Route"
      expect(first.address[:city]).must_equal "Connellymouth"
      expect(first.address[:state]).must_equal "LA"
      expect(first.address[:zip]).must_equal "98872-9105"
    end

    it "Returns accurate information about the 35th customer" do
      # used "35th row" instead of the "last row", since I added "Customer.save" method. 
      thirty_fifth_row = Customer.all[34]

      expect(thirty_fifth_row.id).must_equal 35
      expect(thirty_fifth_row.email).must_equal "rogers_koelpin@oconnell.org"
      expect(thirty_fifth_row.address[:street]).must_equal '7513 Kaylee Summit'
      expect(thirty_fifth_row.address[:city]).must_equal 'Uptonhaven'
      expect(thirty_fifth_row.address[:state]).must_equal 'DE'
      expect(thirty_fifth_row.address[:zip]).must_equal '64529-2614'
    end
  end

  describe "Customer.find" do
    it "Can find the first customer from the CSV" do
      first = Customer.find(1)

      expect(first).must_be_kind_of Customer
      expect(first.id).must_equal 1
    end

    it "Can find the last customer from the CSV" do
      last = Customer.find(35)

      expect(last).must_be_kind_of Customer
      expect(last.id).must_equal 35
    end

    it "Returns nil for a customer that doesn't exist" do
      expect(Customer.find(53145)).must_be_nil
    end
  end
end


# Added (optional for wave 3)
describe "Customer Wave 3 (optional)" do 
  describe "Customer.save" do 
    it "Can save new customer information in the CSV" do 
      # Arrange 
      address = {
        :street => "1299 Westlake Ave",
        :city => "Seattle",
        :state => "WA",
        :zip => "98111"
      }

      new_customer = Customer.new(9898, "hannah@ada.org", address)
      
      # Act & Assert
      Customer.save('data/customers.csv', new_customer)

      expect(
        CSV.read('data/customers.csv').last
      ).must_equal ["9898", "hannah@ada.org", *address.values]
    end 
  end 
end 