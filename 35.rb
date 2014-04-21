# The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.
#
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
#
# How many circular primes are there below one million?

class Integer
  def prime?
  	self > 1 && !(2..Math.sqrt(self)).any? { |i| self % i == 0 }
  end
end

def rotations(p)
  digits = p.to_s.scan(/\d/)
  rotations = (1..digits.size).collect {|o| digits.rotate(o)}
end

def all_rotations_prime?(n)
  rotations(n).all? { |a| a.to_s.gsub(/\D/,'').to_i.prime? }
end

def count_circular_primes_below(n)
  n.downto(2).select {|i| all_rotations_prime?(i) }.count
end

start = Time.now
answer = count_circular_primes_below(1_000_000)

puts "The answer is #{answer} and it took #{(Time.now-start)} seconds."