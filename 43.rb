# The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

# Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

#     d2d3d4=406 is divisible by 2
#     d3d4d5=063 is divisible by 3
#     d4d5d6=635 is divisible by 5
#     d5d6d7=357 is divisible by 7
#     d6d7d8=572 is divisible by 11
#     d7d8d9=728 is divisible by 13
#     d8d9d10=289 is divisible by 17

# Find the sum of all 0 to 9 pandigital numbers with this property

start = Time.now

answer = [0,1,2,3,4,5,6,7,8,9].permutation.select { |n|  n[5] % 5 == 0 && n[3].even? &&( n[7] * 100 + n[8] * 10 + n[9] ) % 17 == 0 &&( n[6] * 100 + n[7] * 10 + n[8] ) % 13 == 0 && ( n[5] * 100 + n[6] * 10 + n[7] ) % 11 == 0 && ( n[4] * 100 + n[5] * 10 + n[6] ) % 7 == 0 && (n[2] + n[3] + n[4] ) % 3 == 0   }.reduce(0) { |acc, n| n[0] != 0 ? acc + (n[9]*10**0 + n[8]*10**1 + n[7]*10**2 + n[6]*10**3 + n[5]*10**4 + n[4]*10**5 + n[3]*10**6 + n[2]*10**7 + n[1]*10**8 + n[0]*10**9) : acc}

puts "The answer is #{answer} and it took #{Time.now - start} seconds."