hash = { :apple => 1.99, banana: 0.49, pear: 1.69 }

# def except!(*keys)
#   new_hash = keys.each { |key| delete(key) }
# end

def except!(*keys)
  new_hash = hash.delete_if { |key, value| key = keys }
end

# new_hash =
except!(:apple)
puts new_hash

# hash = { a: true, b: false, c: nil}
# hash.except!(:c) # => { a: true, b: false}
#   hash # => { a: true, b: false }
