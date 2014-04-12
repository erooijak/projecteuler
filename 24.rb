# A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation 
# of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, 
# we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

# 012   021   102   120   201   210

# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

def permutations(p)
  p.to_s.scan(/\d/).permutation.map{|e| e.join}.sort
end

start = Time.now
answer = permutations(1234567890)[1000000-1]
finish = Time.now

puts "The answer is #{answer} and it took #{finish - start} seconds."