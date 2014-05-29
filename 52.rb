# It can be seen that the number, 125874, and its double, 251748, 
# contain exactly the same digits, but in a different order.

# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, 
# and 6x, contain the same digits.

x = 0
not_found = true
while not_found
  x += 1
  not_found = false if (x.to_s.scan(/\d/) & (2*x).to_s.scan(/\d/) & (3*x).to_s.scan(/\d/) & (4*x).to_s.scan(/\d/) & (5*x).to_s.scan(/\d/) & (6*x).to_s.scan(/\d/)).length == x.to_s.length
end
puts x