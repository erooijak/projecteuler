# A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:
#
#    1/2	= 	0.5
#    1/3	= 	0.(3)
#    1/4	= 	0.25
#    1/5	= 	0.2
#    1/6	= 	0.1(6)
#    1/7	= 	0.(142857)
#    1/8	= 	0.125
#    1/9	= 	0.(1)
#    1/10	= 	0.1
#
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.
# 
# Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.

def number_of_repeating_digits(n)
  repeated = false
  decimals = []
  d = 10
  while !repeated do
    decimals << d / n % 10
    repeated = repeating?(decimals)
    d *= 10
  end
  return decimals.size/2
end

def repeating?(arr)
  return false if arr.size < 2 
  slices = arr.each_slice(arr.size/2).to_a
  return slices[0] == slices[1] && slices[0].inject(:+) > 0
end

# only prime numbers as they have longest recurring cycles as per mathematical evidence 
# http://en.wikipedia.org/wiki/Recurring_decimal#Fractions_with_prime_denominators

class Integer 
  def prime?
    return false if self <= 1
    2.upto(Math.sqrt(self)) do |i|
      return false if self % i == 0 
    end
    return true
  end
end

def get_number_with_maximum_number_of_repeating_digits()
  amount_of_repeating_digits = Hash.new
  (6..1000).each do |n|
	  amount_of_repeating_digits[n] = number_of_repeating_digits(n) if n.prime?
  end
  return amount_of_repeating_digits.max_by{|k,v| v}[0]
end

start = Time.now
answer = get_number_with_maximum_number_of_repeating_digits()
puts "The answer is #{answer} and it took #{Time.now-start} seconds."