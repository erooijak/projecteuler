# The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may 
# incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.
#
# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
#
# There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing 
# two digits in the numerator and denominator.
#
# If the product of these four fractions is given in its lowest common terms, find the value of the denominator.

def non_trivial_fraction?(x,y)
  non_trivial_fraction = false
  
  splitx = x.to_s.scan(/\d/).map{|s| s.to_i}
  splity = y.to_s.scan(/\d/).map{|s| s.to_i}
  
  a=splitx[0]
  b=splitx[1]
  c=splity[0]
  d=splity[1]
  fraction = Rational(x,y)
  (fraction<1)&&((a==c&&d!=0&&Rational(b,d)==fraction)||(a==d&&c!=0&&Rational(b,c)==fraction)||(b==c&&d!=0&&Rational(a,d)==fraction)||(b==d&&c!=0&&Rational(a,c)==fraction&&b!=0&&d!=0))
end

start = Time.now
answer = (10..99).to_a.repeated_permutation(2).select{|x,y| non_trivial_fraction?(x,y)}.map{|x,y| Rational(x,y)}.inject(:*).denominator

puts "The answer is #{answer} and it took #{(Time.now-start)*1000} milliseconds."