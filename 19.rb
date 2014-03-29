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

beginnings= [0,31,59,90,120,151,181,212,243,273,304,334]	# jan = 31, feb =jan + 28 = 59, mar = jan + feb + 31 = 90, etc.
leap_beginnings = beginnings.map.with_index {|month,i| (i > 1) ? month + 1 : month }
sundays = []
starting_days_of_month = []

number_of_days = (0..100).inject(0) { |total_days,i| total_days + ((i % 4 == 0) ? 366 : 365) } 
(0..number_of_days).each { |day_number| sundays.push(day_number) if day_number % 7 == 0 }

def leap_year?(year)
  year % 4 == 0 && (year % 400 == 0 || year % 100 != 0)
end

def offset(array)
  if array.size == 0
    0
  else
    array.max + 31    # because dezember
  end
end

(1901..2000).each_with_index do |year, index|
  days = leap_year?(year) ? leap_beginnings : beginnings
  starting_days_of_month += days.map { |day| day + offset(starting_days_of_month) }
end

puts (starting_days_of_month & sundays).count