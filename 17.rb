# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
# 
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
#
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.


# CODE TAKEN FROM http://johnnycoder.com/blog/2010/07/09/project-euler-17-ruby/
class Integer
  def to_word
    # Interesting, if I rearrange the unless clause to
    # read unless self === (1..1000) the exception is
    # always raised.
    raise ArgumentError, "Integer must be between 1 " \
      + "and 1000" unless (1..1000) === self
      # self.between?(1,1000) would work too.
           
    h = { 1 => "one", 2 => "two", 3 => "three",
      4 => "four", 5 => "five", 6 => "six",
      7 => "seven", 8 => "eight", 9 => "nine",
      10 => "ten", 11 => "eleven", 12 => "twelve",
      13 => "thirteen", 14 => "fourteen", 15 => "fifteen",
      16 => "sixteen", 17 => "seventeen", 18 => "eighteen",
      19 => "nineteen", 20 => "twenty", 30 => "thirty",
      40 => "forty", 50 => "fifty", 60 => "sixty",
      70 => "seventy", 80 => "eighty", 90 => "ninety",
      100 => "hundred", 1000 => "thousand" }
     
    word = ""
     
    # Reverse the numbers so position (ones, tens,
    # hundreds,...) can be easily determined
    a = self.to_s.reverse.split(//).map { |char| char.to_i }
 
    # Thousands position
    if (a[3] != nil and a[3] != 0)
      # This can only be one thousand based
      # on the problem/method constraints
      word = h[a[3]] + " thousand "    
    end
     
    # Hundreds position
    if (a[2] != nil and a[2] != 0)
      word += h[a[2]] + " hundred"
       
      # Add "and" string if the tens or ones
      # position is occupied with a non-zero value.
      # Note: routine is broken up this way for [my] clarity.
      if (a[1] != nil and a[1] != 0)
          # catch 10 - 99
          word += " and"
      elsif a[0] != nil and a[0] != 0
          # catch 1 - 9
          word += " and"
      end       
    end
               
    # Tens and ones position
    tens_position_value = 99
    if (a[1] != nil and a[1] != 0) 
      # Calculate the tens position value per the
      # first and second element in array
      # e.g. (8 * 10) + 1 = 81
      tens_position_value = a[1] * 10 + a[0]
       
      if tens_position_value <= 20
        # If the tens position value is 20 or less
        # there's an entry in the hash. Use it and there's
        # no need to consider the ones position 
        word += " " + h[tens_position_value]   
      else
        # Determine the tens position word by
        # dividing by 10 first. E.g. 8 * 10 = h[80]
        # We will pick up the ones position word later in
        # the next part of the routine       
        word += " " + h[(a[1] * 10)]              
      end
    end
     
    if (a[0] != nil and a[0] != 0 and tens_position_value > 20)
        # Deal with ones position where tens position is
        # greater than 20 or we have a single digit number       
        word += " " + h[a[0]]       
    end
     
    # Trim the empty spaces off both ends of the string
    word.strip
  end
   
   def to_word_length    
     self.to_word.gsub(/ /,'').length         
      
     # I original wrote the result as follows:
     #    self.to_word.gsub(' ','').length
     # but from what I've read it seems that providing
     # a regex as the first argument is more Ruby-like
   end
end
 
puts (1..1000).inject(0) { |agg, i| agg + i.to_word_length }
 
puts "Elapsed Time: #{(Time.now - timer_start)*1000} milliseconds"