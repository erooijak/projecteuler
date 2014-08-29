# A googol (10100) is a massive number: one followed by one-hundred zeros; 100100 is almost unimaginably large: 
# one followed by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.

# Considering natural numbers of the form, ab, where a, b < 100, what is the maximum digital sum?


# Considering natural numbers of the form, a^b, where a, b < 100, what is the maximum sum of their digits?
p (1..100).to_a.permutation(2).to_a.map { |a| (a[0]**a[1]).to_s.scan(/\d/).map { |s| s.to_i }.inject(:+) }.max