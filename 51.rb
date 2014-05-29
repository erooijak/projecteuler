# By replacing the 1st digit of the 2-digit number *3, it turns out that six 
# of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.

# By replacing the 3rd and 4th digits of 56**3 with the same digit, this 
# 5-digit number is the first example having seven primes among the ten 
# generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 
# 56773, and 56993. Consequently 56003, being the first member of this family, 
# is the smallest prime with this property.

# Find the smallest prime which, by replacing part of the number (not 
# necessarily adjacent digits) with the same digit, is part of an eight prime 
# value family.

require 'prime'

def is_eight_times_prime_by_replacing_part_of_the_number?(prime)
  number_array = prime.to_s.scan(/\d/).map { |char| char.to_i }

  #Substitute 1 value, return true if all resulting values are prime
  length = number_array.size
  (0..length-1).to_a.each  { |i|
    replacement_primes = []
    (0..9).each { |k|
      temp_number_array = number_array.dup 
      temp_number_array[i] = k
      value = temp_number_array.join.to_i
      replacement_primes << value if Prime.prime?(value) && !(i == 0 && temp_number_array[0] == 0)
    }
    return true if replacement_primes.size == 8
  } 

  # Substitute 2 values, return true if all resulting 
  # values are prime
  (0..length-1).to_a.combination(2).each  { |i,j|
    replacement_primes = []
    (0..9).each { |k| 
      temp_number_array = number_array.dup 
	  temp_number_array[i] = k
	  temp_number_array[j] = k
	  value = temp_number_array.join.to_i
	  replacement_primes << value if Prime.prime?(value) && !(i == 0 && temp_number_array[0] == 0)
    }
    return true if replacement_primes.size == 8
  }

  # Substitute 3 values, return true if all resulting 
  # values are prime
  (0..length-1).to_a.combination(3).each  { |i,j,l|
    replacement_primes = []
    (0..9).each { |k| 
      temp_number_array = number_array.dup 
	  temp_number_array[i] = k
	  temp_number_array[j] = k
	  temp_number_array[l] = k
	  value = temp_number_array.join.to_i
	  replacement_primes << value if Prime.prime?(value) && !(i == 0 && temp_number_array[0] == 0)
    }
    return true if replacement_primes.size == 8
  }

  # skip 4 values or more

  return false
end

Prime.lazy.each { |p| 
  break if is_eight_times_prime_by_replacing_part_of_the_number?(p)
}
# Result => 120383, which is substitution of 
# *2*3*3
# 121313
# 222323
# 323333
# 424343
# 525353
# 626363
# 828383
# 929393
# so, 121313 is the smallest prime and the answer