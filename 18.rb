# By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
#
# 3
# 7 4
# 2 4 6
# 8 5 9 3
# 
# That is, 3 + 7 + 4 + 9 = 23.
# 
# Find the maximum total from top to bottom of the triangle below:
# 
#                      75
#                    95 64
#                   17 47 82
#                 18 35 87 10
#                20 04 82 47 65
#              19 01 23 75 03 34
#             88 02 77 73 07 63 67
#           99 65 04 28 06 16 70 92
#          41 41 26 56 83 40 80 70 33
#        41 48 72 33 47 32 37 16 94 29
#       53 71 44 65 25 43 91 52 97 51 14
#     70 11 33 28 77 73 17 78 39 68 17 57
#    91 71 52 38 17 14 91 43 58 50 27 29 48
#  63 66 04 68 89 53 67 30 73 16 69 87 40 31
# 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

# NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. 
# However, Problem 67, is the same challenge with a triangle containing one-hundred rows; it cannot 
# be solved by brute force, and requires a clever method! ;o)

triangle = "75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"

# BRUTE FORCE ANYWAY

# Lengths are 1, 2, 3 ... 15
# If first 0 then second can be 0 and 1. If second 0 then third can be 0 and 1, if second 1 it can be 1 and 2
# If third 0 it can be 0 and 1, if 1 it can be, 1 and 2, if 2 it can be 2 and 3, et cetera

# First read in the string and split it into fifteen arrays.

splitted_triangle = triangle.split(/\n/)

list_of_path_values = Array.new

for i in 0..14
	var sum = 0 # STUCK
	splitted_triangle[i].split(/\s/)
end