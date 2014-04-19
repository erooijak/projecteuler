# In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
#
#     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#
# It is possible to make £2 in the following way:
#
#     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
#
# How many different ways can £2 be made using any number of coins?

start = Time.now
ways = 0
0.upto 1 do |i|
  a = 200 * i 
  if a > 200 then next end
  0.upto 2 do |j|
  	b = 100 * j 
  	if a+b > 200 then next end
  	0.upto 4 do |k|
  	  c = 50 * k 
  	  if a+b+c > 200 then next end
  	  0.upto 10 do |l|
  	    d = 20 * l 
  	    if a+b+c+d > 200 then next end
  	    0.upto 20 do |m|
          e = 10 * m 
          if a+b+c+d+e > 200 then next end
          0.upto 40 do |n|
            f = 5 * n 
            if a+b+c+d+e+f > 200 then next end
            0.upto 100 do |o|
              g = 2 * o 
              if a+b+c+d+e+f+g > 200 then next end
              0.upto 200 do |p|
              	h = 1 * p 
              	if a+b+c+d+e+f+g+h > 200 then next end
              	ways += 1 if a+b+c+d+e+f+g+h == 200 end end end end end end end end

puts "The answer is #{ways} and it took #{Time.now-start} seconds."