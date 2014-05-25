# The first two consecutive numbers to have two distinct prime factors are:

# 14 = 2 × 7
# 15 = 3 × 5

# The first three consecutive numbers to have three distinct prime factors are:

# 644 = 2² × 7 × 23
# 645 = 3 × 5 × 43
# 646 = 2 × 17 × 19.

# Find the first four consecutive integers to have four distinct prime factors. 
# What is the first of these numbers?

require 'prime'

puts (646..Float::INFINITY).lazy.each_cons(4).select { |arr| arr.all? {|e| e.prime_division.size == 4 }}.first[0]