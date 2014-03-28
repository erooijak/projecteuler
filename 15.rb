# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.
# 
# How many such routes are there through a 20×20 grid?

# 40!/20!^2

start = Time.now
def factorial(n)
	result = 1
	for i in 1..n 
		result *= i
	end
	return result
end

answer = factorial(40) / factorial(20) ** 2
finish = Time.now
elapsed = finish - start

puts "The answer is #{answer} and it took #{elapsed} seconds"