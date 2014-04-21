# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
#
# Find the sum of all numbers which are equal to the sum of the factorial of their digits.
#
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.

class Integer
  def factorial
    (1..self).reduce(1, :*)
  end
end

start = Time.now
answer = 0;
10.upto(2540161) do |i|
  sum_of_facts = 0
  number = i
  while number > 0
  	d = number % 10
  	number /= 10
  	sum_of_facts += d.factorial
  end
  answer += i if sum_of_facts == i
end

puts "The answer is #{answer} and it took #{(Time.now-start)} seconds."