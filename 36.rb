# The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
#
# Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
#
# (Please note that the palindromic number, in either base, may not include leading zeros.)

puts (1..1_000_000).reduce {|acc,val| val.to_s == val.to_s.reverse && val.to_s(2) == val.to_s(2).reverse ? acc + val : acc}