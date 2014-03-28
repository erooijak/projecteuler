# 21^5 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
# 
# What is the sum of the digits of the number 2^1000?

start = Time.now 
value = 2**1000
answer = value.to_s.scan(/\d/).map { |x| x.to_i }.inject(:+)
finish = Time.now
elapsed = finish - start

puts "The answer is #{answer} and it took #{elapsed} seconds."