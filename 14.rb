# The following iterative sequence is defined for the set of positive integers:
#
# n → n/2 (n is even)
# n → 3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following sequence:
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
# 
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
# 
# Which starting number, under one million, produces the longest chain?
# 
# NOTE: Once the chain starts the terms are allowed to go above one million.

start = Time.now
maximum = 1000001

def collatz(first)
   	seq = Array.new
   	seq.push(first)

   	value = first

   	until (value == 1 ) do
   		if value % 2 == 0 
   			value = value / 2
   		else
   			value = value * 3 + 1
   		end
   		seq.push(value)
	end
	return seq
end

seqs = Array.new
lengths = Array.new
for i in 1..maximum
	seqs.push(collatz(i))
	lengths.push(collatz(i).length)
	puts i
end

answer = lengths.max
index = lengths.index(answer)
finish = Time.now
elapsed = finish - start

puts "The maximum length is #{answer}. The Collatz sequence is #{seqs[index]} and it took #{elapsed} seconds"