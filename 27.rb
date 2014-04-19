# Euler discovered the remarkable quadratic formula:
#
# n² + n + 41
#
# It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. 
# However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when 
# n = 41, 41² + 41 + 41 is clearly divisible by 41.
#
# The incredible formula  n² − 79n + 1601 was discovered, which produces 80 primes for the 
# consecutive values n = 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
#
# Considering quadratics of the form:
#
#     n² + an + b, where |a| < 1000 and |b| < 1000
#
#     where |n| is the modulus/absolute value of n
#     e.g. |11| = 11 and |−4| = 4
#
# Find the product of the coefficients, a and b, for the quadratic expression that produces the 
# maximum number of primes for consecutive values of n, starting with n = 0.

class Integer 
  def prime?
    return false if self < 1
    2.upto(Math.sqrt(self)) do |i|
      return false if self % i == 0 
    end
    return true
  end
end

def get_amount_of_primes_from_quadratic_formula(a,b)
	primes = []
  still_all_primes = true
  n = 0
  while still_all_primes
  	result = n**2 + a*n + b
  	if result.prime? then
      primes << result
    else 
    	still_all_primes = false
    end
    n += 1
  end
  return primes.size
end

def get_product_of_coefficients_that_produce_maximum_number_of_primes_for_consecutive_values()
	max_product = 0
	max_primes = 0
  -999.upto(1000) do |a|
  	-999.upto(1000) do |b|
  		primes = get_amount_of_primes_from_quadratic_formula(a,b)
  		if primes > max_primes then
  			max_primes = primes
  			max_product = a*b 
  		end
  	end
  end
  return max_product
end

start = Time.now
answer = get_product_of_coefficients_that_produce_maximum_number_of_primes_for_consecutive_values()

puts "The answer is #{answer} and it took #{Time.now-start} seconds."