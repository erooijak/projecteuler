# Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is 
# formed as follows:
#
# 21 22 23 24 25
# 20  7  8  9 10
# 19  6  1  2 11
# 18  5  4  3 12
# 17 16 15 14 13
#
# It can be verified that the sum of the numbers on the diagonals is 101.
#
# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?

def create_grid(size)
  numbers = [*1..size**2]
  grid = Array.new(size) {Array.new(size)}

  0.upto(size) do |j|
    (size-(j+1)).downto(j) do |i| 
  	  grid [j][i] = numbers.pop
    end
    (j+1).upto(size-(j+1)) do |i| 
      grid [i][j] = numbers.pop
    end

    (j+1).upto(size-(j+1)) do |i|
      grid[size-(j+1)][i] = numbers.pop
    end

    (size-(j+2)).downto(j+1) do |i|
      grid[i][size-(j+1)] = numbers.pop
    end
  end
  grid
end
 
def sum_diagonals(grid)
  grid.each_index.inject{|acc, i| acc + grid[i][i] + grid[i][-1 - i]}
end

start = Time.now
answer = sum_diagonals(create_grid(1001))

puts "The answer is #{answer} and it took #{Time.now-start} seconds."