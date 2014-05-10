# An irrational decimal fraction is created by concatenating the positive integers:

# 0.123456789101112131415161718192021...

# It can be seen that the 12th digit of the fractional part is 1.

# If dn represents the nth digit of the fractional part, find the value of the following expression.

# d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

start = Time.now
answer = ("0".."200000").reduce {|acc, n| acc.concat(n)}.scan(/\d/).map{|d| d.to_i }.values_at(10**0,10**1,10**2,10**3,10**4,10**5,10**6).inject(:*)

puts "The answer is #{answer} and it took #{Time.now - start} seconds."