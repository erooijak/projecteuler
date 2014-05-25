# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases 
# by 3330, is unusual in two ways: (i) each of the three terms are prime, and, 
# (ii) each of the 4-digit numbers are permutations of one another.

# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, 
# exhibiting this property, but there is one other 4-digit increasing sequence.

# What 12-digit number do you form by concatenating the three terms in this sequence?

require 'prime'

class Integer
  def permutation? n
	(self.to_s.scan(/\d/) - n.to_s.scan(/\d/)).empty?
  end
end

start = Time.now

         #http://primes.utm.edu/howmany.shtml
answer = Prime.take(858).drop(168).each.map {|i| 
  [i, i + 3330, i + 6660]}.select{|i,j,k|
  i.permutation?(j) && 
  j.permutation?(k) &&
  j.prime? && k.prime?
}[1].join.to_i

puts "The answer is #{answer} and it took #{(Time.now-start)*1000} milliseconds."