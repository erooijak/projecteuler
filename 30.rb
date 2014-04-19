# Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:
#
#     1634 = 14 + 64 + 34 + 44
#     8208 = 84 + 24 + 04 + 84
#     9474 = 94 + 44 + 74 + 44
#
# As 1 = 14 is not a sum it is not included.
#
# The sum of these numbers is 1634 + 8208 + 9474 = 19316.
#
# Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

def sum_digits_to_power_of_5(n)
  sum = n.to_s.scan(/\d/).inject(0){|acc,i| acc + i.to_i ** 5}
  if sum == n then
  	return sum
  else
  	return 0
  end
end

start = Time.now
answer = (2..999999).inject(0){|acc,n| acc + sum_digits_to_power_of_5(n)}

puts "The answer is #{answer} and it took #{Time.now-start} seconds."