# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
# 
# For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
# 
# What is the total of all the name scores in the file?


names = File.read('names.txt').scan(/"([^"]*)"/).sort

score = 0

names.each_with_index do |name, index|
	temp = 0
	letters = name.to_s.scan(/(.)/)
	letters.each do |letter|
		temp += 1 if letter.to_s.match(/A/)
		temp += 2 if letter.to_s.match(/B/)
		temp += 3 if letter.to_s.match(/C/)
		temp += 4 if letter.to_s.match(/D/)
		temp += 5 if letter.to_s.match(/E/)
		temp += 6 if letter.to_s.match(/F/)
		temp += 7 if letter.to_s.match(/G/)
		temp += 8 if letter.to_s.match(/H/)
		temp += 9 if letter.to_s.match(/I/)
		temp += 10 if letter.to_s.match(/J/)
		temp += 11 if letter.to_s.match(/K/)
		temp += 12 if letter.to_s.match(/L/)
		temp += 13 if letter.to_s.match(/M/)
		temp += 14 if letter.to_s.match(/N/)
		temp += 15 if letter.to_s.match(/O/)
		temp += 16 if letter.to_s.match(/P/)
		temp += 17 if letter.to_s.match(/Q/)
		temp += 18 if letter.to_s.match(/R/)
		temp += 19 if letter.to_s.match(/S/)
		temp += 20 if letter.to_s.match(/T/)
		temp += 21 if letter.to_s.match(/U/)
		temp += 22 if letter.to_s.match(/V/)
		temp += 23 if letter.to_s.match(/W/)
		temp += 24 if letter.to_s.match(/X/)
		temp += 25 if letter.to_s.match(/Y/)
		temp += 26 if letter.to_s.match(/Z/)
	end
	score += (index+1) * temp
end

puts score