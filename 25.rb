# The Fibonacci sequence is defined by the recurrence relation:
#
#    Fn = Fn−1 + Fn−2, where F1 = 1 and F2 = 1.

# Hence the first 12 terms will be:
#
#    F1 = 1
#    F2 = 1
#    F3 = 2
#    F4 = 3
#    F5 = 5
#    F6 = 8
#    F7 = 13
#    F8 = 21
#    F9 = 34
#    F10 = 55
#    F11 = 89
#    F12 = 144
#
# The 12th term, F12, is the first term to contain three digits.
#
# What is the first term in the Fibonacci sequence to contain 1000 digits?

def do_fibonacci_until_1000_digits()
  f = 1
  n1 = 0
  n2 = 1

  while (n2.to_s.length < 1000)
    n3 = n1+n2
    n1 = n2
    n2 = n3
    f += 1
  end
  puts "The answer is the #{f}th term"
end

start = Time.now
do_fibonacci_until_1000_digits()
puts "and it took #{Time.now-start} seconds."
