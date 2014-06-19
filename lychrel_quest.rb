# 196 palindrome quest 
# John Walker ran something similar in 1987 for almost three years to obtain number of million digits
# Romain Dolbeau reached 600 million digits in 2011 using distributed computing

# http://en.wikipedia.org/wiki/Lychrel_number

class Integer

  def palindromic?
    str = self.to_s
    str == str.reverse
  end

end

value = 0
found = false
time_point = Time.now
n = 196

while (!found)
  n += n.to_s.reverse.to_i
  found = true if n.palindromic?
  value += 1

  if (Time.now.to_i - time_point.to_i) > 7200 then #every two hours write checkpoint
    time_point = Time.now
    File.open("lychrel_quest.txt", "a") do |file|
       file.puts "Time: #{Time.now}\nIteration: #{value}\nLength: #{n.to_s.length}\n\n"
    end
  end

  if found then
    File.open("lychrel_quest.txt", "a") do |file|
       file.puts "Time: #{Time.now}\nIteration: #{value}\nValue: #{n}\nLength: #{n.to_s.length}"
    end
  end

end