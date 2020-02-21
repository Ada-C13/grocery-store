#!/usr/bin/ruby
# 
# Title  : Customer - Ada Cohort 13 - Space
# Author : Suely Barreto
# Date   : February 2020
# 

class Customer

  attr_reader   :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  

end

