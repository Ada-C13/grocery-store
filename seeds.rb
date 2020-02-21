require 'csv'
require 'faker'

# Students do not need to modify this file
# This is the file created by instructors to create all CSV files

# orders
# id = 1
# CSV.open("support/orders.csv", "w") do |csv|
#   100.times do
#     foods = ""
#     rand(1..4).times do
#       foods += Faker::Food.ingredient + ":" + Faker::Commerce.price.to_s + ";"
#     end
#
#     foods = foods.chomp(';')
#     csv << [id, foods]
#     id += 1
#   end
# end

# customers
# id = 1
# CSV.open("support/customers.csv", "w") do |csv|
#   35.times do
#     csv << [id, Faker::Internet.email,
#       Faker::Address.street_address, Faker::Address.city, Faker::Address.state_abbr, Faker::Address.zip_code]
#     id += 1
#   end
# end

# online orders
# id = 1
# statuses = %i(pending paid processing shipped complete)
# CSV.open("support/online_orders.csv", "w") do |csv|
#   100.times do
#     foods = ""
#     rand(1..4).times do
#       foods += Faker::Food.ingredient + ":" + Faker::Commerce.price.to_s + ";"
#     end
#
#     foods = foods.chomp(';')
#     # id, string of foods, customer ID, random status
#     csv << [id, foods, rand(1..35), statuses.sample]
#     id += 1
#   end
# end
