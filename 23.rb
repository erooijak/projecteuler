# A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. 
# For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 
# 28 is a perfect number.
# A number n is called deficient if the sum of its proper divisors is less than n and it is called 
# abundant if this sum exceeds n.
# 
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written 
# as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers 
# greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot 
# be reduced any further by analysis even though it is known that the greatest number that cannot be 
# expressed as the sum of two abundant numbers is less than this limit.

# Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

start = Time.now

def sum_proper_divisors(n)
  (1..n/2).inject(0) {|total,m| (n%m).zero? ? total+m : total}
end

def abundant_number?(n)
  sum_proper_divisors(n) > n
end

def get_list_abundant_numbers(n)
  (1..n).select{|n| abundant_number?(n)}
end

def any_two_can_be_summed_to_value?(list, value)
  max = index_of_smallest_abundant_number_that_is_bigger_than_n(list,value)
  0.upto(max) do |i|
    i.upto(max) do |j|
      if list[i] + list[j] == value
        return true
      end
    end
  end
  return false
end

def index_of_smallest_abundant_number_that_is_bigger_than_n(list,n)
  list.each_with_index do |elmt,index|
    if elmt > n
      return index
    end
  end
  return list.size-1
end

max_value = 28123
list = get_list_abundant_numbers(max_value)
answer = (1..max_value).inject(0) {|total, m| any_two_can_be_summed_to_value?(list,m) ? total : total+m} 

puts "The answer is #{answer} and it took #{ ((Time.now - start) / 60).round} minutes."