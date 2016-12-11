# In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
#
#     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#
# It is possible to make £2 in the following way:
#
#     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
#
# How many different ways can £2 be made using any number of coins?

coins = [1, 2, 5, 10, 20, 50, 100, 200]

def count_ways(coins, amount)
  if (amount < 0 || coins.empty?)
    0
  elsif (amount == 0)
    1
  else 
    count_ways(coins, amount - coins[0]) + count_ways(coins[1..-1], amount)
  end
end

puts count_ways(coins, 200)
