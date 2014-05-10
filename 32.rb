# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; 
# for example, the 5-digit number, 15234, is 1 through 5 pandigital.
#
# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and 
# product is 1 through 9 pandigital.
#
# Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 
# 9 pandigital.
# HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

def pandigital?(n)
  numbers = n.scan(/\d/).to_a
  numbers.length == 9 && numbers.length == numbers.uniq.length && ([*"1".."9"] - numbers).empty?
end

def has_pandigital_multiplicand_multiplier_product_identity?(n)
  2.upto n/2 do |i|
    if n%i == 0 then
       multiplicand = i
       multiplier = n/i
       if pandigital?("#{multiplicand}#{multiplier}#{n}") then
       	return true
       end
    end
  end
  false
end

def get_sum_of_all_pandigital_multiplicand_multiplier_product_identities(max)
  (1..max).inject(0) {|acc,n| has_pandigital_multiplicand_multiplier_product_identity?(n) ? acc + n : acc}
end

start = Time.now
answer = get_sum_of_all_pandigital_multiplicand_multiplier_product_identities(7852)

puts "The answer is #{answer} and it took #{Time.now-start} seconds."