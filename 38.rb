# Take the number 192 and multiply it by each of 1, 2, and 3:

#     192 × 1 = 192
#     192 × 2 = 384
#     192 × 3 = 576

# By concatenating each product we get the 1 to 9 pandigital, 
# 192384576. We will call 192384576 the concatenated product 
# of 192 and (1,2,3)

# The same can be achieved by starting with 9 and multiplying 
# by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, 
# which is the concatenated product of 9 and (1,2,3,4,5).

# What is the largest 1 to 9 pandigital 9-digit number that 
# can be formed as the concatenated product of an integer 
# with (1,2, ... , n) where n > 1?

def pandigital?(n)
  numbers = n.to_s.scan(/\d/).to_a
  numbers.length == 9 && numbers.length == numbers.uniq.length && ([*"1".."9"] - numbers).empty?
end

def get_concatenated_product n
  n*10**5 + n*2
end

start = Time.now
answer =  (9000..9999).map {|n| get_concatenated_product(n)}.select {|n| pandigital?(n)}.max

puts "The answer is #{answer} and it took #{(Time.now-start)*1000} milliseconds."