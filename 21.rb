# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
# 
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
# 
# Evaluate the sum of all the amicable numbers under 10000.

def d(n)
  (1..n/2).inject(0) { |total, m| (n % m).zero? ? total + m : total }
end

def amicable_pair?(a,b)
  a != b && d(a) == b && d(b) == a
end

def add_amicable_pairs(n)
  amicable_values = []
  for i in 1..n
  	for j in 1..n
  	  if (amicable_pair?(i,j)) 
  	  	amicable_values.push(i)
  	  	puts "added #{i} from amicable pair #{i}, #{j}"
  	  end
  	end
  end
  return amicable_values.inject(:+)
end

start = Time.now
puts add_amicable_pairs(10000)
finish = Time.now
puts "Elapsed time is #{finish-start}"