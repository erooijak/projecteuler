# The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
#
# Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
#
# (Please note that the palindromic number, in either base, may not include leading zeros.)

def palindromic?(n)
  n.to_s == n.to_s.reverse
end

def sum_of_palindromic_numbers_in_base2_and_base10_upto(n)
  (1..n).reduce {|acc,val| palindromic?(val) && palindromic?(val.to_s(2)) ? acc + val : acc}
end

start = Time.now
answer = sum_of_palindromic_numbers_in_base2_and_base10_upto(1_000_000)

puts "The answer is #{answer} and it took #{Time.now-start} seconds."