# The sum of the squares of the first ten natural numbers is,
# 12 + 22 + ... + 102 = 385

# The square of the sum of the first ten natural numbers is,
# (1 + 2 + ... + 10)2 = 552 = 3025

# Hence the difference between the sum of the squares of the 
# first ten natural numbers and the square of the sum is 
# 3025 − 385 = 2640.

# Find the difference between the sum of the squares of the 
# first one hundred natural numbers and the square of the sum.

start = Time.now
answer = ((0..100).inject(:+))**2-(0..100).reduce(0) {|acc,n| acc + n**2}

puts "The answer is #{answer} and it took #{(Time.now-start)*1000} milliseconds."