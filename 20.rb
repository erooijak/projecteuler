# n! means n × (n − 1) × ... × 3 × 2 × 1
#
# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#
# Find the sum of the digits in the number 100!

def fact(n)
  (1..n).inject(:*)
end

def sum_digits(n)
  n.to_s.scan(/.{1}/).map { |x| x.to_i }.inject(:+)
end

puts sum_digits(fact(100))