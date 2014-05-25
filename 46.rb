# It was proposed by Christian Goldbach that every odd composite number can be written as the sum of 
# a prime and twice a square.

# 9 = 7 + 2×12
# 15 = 7 + 2×22
# 21 = 3 + 2×32
# 25 = 7 + 2×32
# 27 = 19 + 2×22
# 33 = 31 + 2×12

# It turns out that the conjecture was false.

# What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?

require 'prime'

def goldbach?(composite_number)
  goldbach = false
  primes = Prime.take_while {|p| p <= composite_number}
  
  0.upto(primes.size-1) do |i|
  	0.upto(Math.sqrt(composite_number)) do |j|
  	  if primes[i] + 2*j**2 == composite_number then
  	  	goldbach = true
  	  	break
  	  end
  	end
  end
  goldbach
end

start = Time.now
answer = (2..Float::INFINITY).lazy.select { |n| n % 2 != 0 && !goldbach?(n)  }.first

puts "The answer is #{answer} and it took #{Time.now - start} seconds."