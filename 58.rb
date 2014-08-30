# Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.
# 
# 37 36 35 34 33 32 31
# 38 17 16 15 14 13 30
# 39 18  5  4  3 12 29
# 40 19  6  1  2 11 28
# 41 20  7  8  9 10 27
# 42 21 22 23 24 25 26
# 43 44 45 46 47 48 49
# 
# It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting 
# is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.
# 
# If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. 
# If this process is continued, what is the side length of the square spiral for which the ratio of primes along 
# both diagonals first falls below 10%?

require 'prime'

# We use a mathematical derivation of the corner values, keep increasing the value till we find a ratio smaller 
# than 0.10 and increase the grid_size and amount of numbers on diagonals each iteration

side_length = 3 # start with grid size of 3x3  so that we do not get into trouble with 1x1 grid
prime_count = 3 # 3, 5, 7 are prime and on a diagonal in a 3x3 grid
diagonal_size = 5
prime_ratio = 1 # dummy value bigger than 0.10 so we can start the loop

while prime_ratio >= 0.10
  # Increase the side length by two (full spiral) and diagonal size by four
  side_length += 2 and diagonal_size += 4
  # Add one to prime count for each corner if it is prime
  # Corners are given by n2 (top left), n2-n+1, n2-2n+2, and n2-3n+3
  prime_count += 1 if (side_length**2).prime?
  prime_count += 1 if (side_length**2-side_length+1).prime?
  prime_count += 1 if (side_length**2-2*side_length+2).prime?
  prime_count += 1 if (side_length**2-3*side_length+3).prime?
  # Divide amount of primes counted by the diagonal length to get prime ratio 
  prime_ratio = prime_count/diagonal_size.to_f
end

puts side_length

# Brute force was waaay too slow since it counted all primes every round ( seconds)...
# 
# def create_grid(size)
#   numbers = [*1..size**2]
#   grid = Array.new(size) {Array.new(size)}
# 
#   0.upto(size) do |i|
#     (size-(i+1)).downto(i) do |j|
#       grid [i][j] = numbers.pop
#     end
#     (i+1).upto(size-(i+1)) do |j|
#       grid[j][i] = numbers.pop
#     end
#     (i+1).upto(size-(i+1)) do |j|
#       grid[size-(i+1)][j] = numbers.pop
#     end
#     (size-(i+2)).downto(i+1) do |j|
#       grid[j][size-(i+1)] = numbers.pop
#     end
#   end
# 
#   grid
# end
# 
# def diagonal_prime_count(grid) 
#   (0...grid.size).inject(0) { |acc, i| grid[i][i].prime? && grid[i][-1-i].prime? ? 
# 			               acc + 2 : (grid[i][i].prime? || grid[i][-1-i].prime? ? acc + 1 : acc) }
# end
# 
# start = Time.now
# index = 0
# prime_ratio = 1
# grid_size = 3 # (Skip grid of size 1x1) 
# diagonal_number_count = 5
# while prime_ratio >= 0.10
#   prime_ratio = diagonal_prime_count(create_grid(grid_size))/diagonal_number_count.to_f
#   grid_size += 2 and diagonal_number_count += 4 and index += 1 if prime_ratio >= 0.10
#   puts "Once again... \n\tGrid size:\t#{grid_size}\n\tPrime ratio:\t#{prime_ratio}\n\tTime spent:\t#{Time.now-start}\n\tRatio left:\t#{prime_ratio-0.10}\n" if index % 100 == 0
# end
# 
# puts grid_size
