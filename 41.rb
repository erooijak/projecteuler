# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. 
# For example, 2143 is a 4-digit pandigital and is also prime.

# What is the largest n-digit pandigital prime that exists?

require 'prime'

def pandigital?(n)
  numbers = n.to_s.scan(/\d/).to_a
  numbers.length == 7 && numbers.length == numbers.uniq.length && ([*"1".."7"]-numbers).empty?
end

def largest_7digit_pandigial_prime(start_number)
  enum = Prime.each
  arr = []
  [*start_number..7654321].each do |_|
    n = enum.next
    arr << n if pandigital?(n)
  end
  return arr.max
end

start = Time.now
answer = largest_7digit_pandigial_prime(7123456)

puts "The answer is #{answer} and it took #{Time.now-start} seconds."

#Inspirational (was faster)
p [1,2,3,4,5,6,7].permutation.to_a.map{|a| n = a.inject(0){|s,d|s=s*10+d}; n.prime? ? n : 
nil}.compact.sort[-1]