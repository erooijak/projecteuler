# The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits 
# from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 
# 3797, 379, 37, and 3.
#
# Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
#
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

require 'prime'

class Integer
  def is_truncable?
  	truncable = true
    str, str2= self.to_s, self.to_s
    if self == 2 || self == 3 || self == 5 || self == 7 then return false end
    while str.size > 0
      if !Prime.prime?(str.to_i) || !Prime.prime?(str2.to_i) then truncable = false end
      str = str.chop
      str2 = str2[1..-1]
    end
    truncable
  end
end

start = Time.now
answer = Prime.lazy.select {|p| p.is_truncable? }.take(11).inject(:+)

puts "The answer is #{answer} and it took #{(Time.now-start)} seconds."