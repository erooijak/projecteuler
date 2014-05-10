# If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.

# {20,48,52}, {24,45,51}, {30,40,50}

# For which value of p ≤ 1000, is the number of solutions maximised?

def largest_hash_key(hash)
  hash.max_by{|k,v| k}
end

def amount_of_solutions(n)
  solutions = 0
  if n.even? then
    1.upto(n/3) do |i|
      i.upto(n/2) do |j|
        next if i+j>n
        k = i**2+j**2
        solutions += 1 if i+j+Math.sqrt(k)==n
      end
    end
  end
  return solutions, n  
end

start = Time.now
answer = largest_hash_key((1..999).map {|n| amount_of_solutions(n)})[1]

puts "The answer is #{answer} and it took #{Time.now-start} seconds."