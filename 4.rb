# Code for inspiration

max = 0
100.upto(999) { |a|
  a.upto(999) { |b|
    prod = a * b
    max = [max, prod].max if prod.to_s == prod.to_s.reverse
  }
}
puts "Maximum palindrome is #{ max }."