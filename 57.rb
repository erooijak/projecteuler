#!/usr/bin/ruby)
# It is possible to show that the square root of two can be expressed as an infinite continued fraction.

# √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...

# By expanding this for the first four iterations, we get:

# 1 + 1/2 = 3/2 = 1.5
# 1 + 1/(2 + 1/2) = 7/5 = 1.4
# 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
# 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...

# The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first example where the number of digits in the numerator exceeds the number of digits in the denominator.

# In the first one-thousand expansions, how many fractions contain a numerator with more digits than denominator?

class Rational
  def numerator_more_digits_than_denominator?
	  self.numerator.to_s.size > self.denominator.to_s.size
  end
end

def expand rational_fraction, iteration, max_iterations, count
	new_rational_fraction = rational_fraction[0..-iteration].gsub(/2$/, '2 + Rational(1, 2' + ')' * iteration)
  iteration += 1
  count += 1 if eval(new_rational_fraction).numerator_more_digits_than_denominator?
  if iteration <= max_iterations
    expand new_rational_fraction, iteration, max_iterations, count
	else
    count
	end
end

puts expand "1 + Rational(1,2)", 1, 1000, 0 



