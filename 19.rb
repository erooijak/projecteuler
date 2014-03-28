# You are given the following information, but you may prefer to do some research for yourself.
#
#    1 Jan 1900 was a Monday.
#    Thirty days has September,
#    April, June and November.
#    All the rest have thirty-one,
#    Saving February alone,
#    Which has twenty-eight, rain or shine.
#    And on leap years, twenty-nine.
#    A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
#
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

# First: calculate the numbers in 1..365 that are the beginning of months for normal years and leap years
# Months have the following length: 31 28 31 30 31 30 31 31 30 31 30 31

beginnings= [0,31,59,90,120,151,181,212,243,273,304,334]
leap_beginnings = beginnings.map.with_index {|n,i| (i > 1) ? n+1 : n }

# Then: collect all Sundays. First the amount of days in the 100 years is calculated and every number that is divisible by seven is a Sunday
sundays = Array.new
number_of_days = (0..100).reduce(0) { |tot,i| tot + ((i%4 == 0) ? 366 : 365) } 

for i in 365..number_of_days #start after 1 non-leap year (365 days)
	if (i % 7 == 0)
		sundays.push(i)
	end
end

# Then collect numbers of beginning of month for all years by adding the arrays to each other.
beginnings = [0,31,59,90,120,151,181,212,243,273,304,334] # jan = 31, feb =jan + 28, mar = jan + feb + 31, etc.
leap_beginnings = beginnings.map.with_index {|n,i| (i > 1) ? n+1 : n }

def leap_year?(year)
  year % 4 == 0
end

def offset(array)
  if array.size == 0
    0
  else
    array.max + 31    # because dezember
  end
end

starting_days_of_month = []

(1900..2000).each_with_index do |year, index|
  days = leap_year?(year) ? leap_beginnings : beginnings

  starting_days_of_month += days.map { |day| day + offset(starting_days_of_month) }
end

#Then intersect the 'starting days of month'-numbers and the sunday-numbers and count.
puts (starting_days_of_month & sundays).count