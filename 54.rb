# n the card game poker, a hand consists of five cards and are ranked, 
# from lowest to highest, in the following way:

#     High Card: Highest value card.
#     One Pair: Two cards of the same value.
#     Two Pairs: Two different pairs.
#     Three of a Kind: Three cards of the same value.
#     Straight: All cards are consecutive values.
#     Flush: All cards of the same suit.
#     Full House: Three of a kind and a pair.
#     Four of a Kind: Four cards of the same value.
#     Straight Flush: All cards are consecutive values of same suit.
#     Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

# If two players have the same ranked hands then the rank made up of the 
# highest value wins; for example, a pair of eights beats a pair of fives 
# (see example 1 below). But if two ranks tie, for example, both players 
# have a pair of queens, then highest cards in each hand are compared 
# (see example 4 below); if the highest cards tie then the next highest 
# cards are compared, and so on.

# Consider the following five hands dealt to two players:
# Hand	 	Player 1	 	Player 2	 	Winner
# 1	 	5H 5C 6S 7S KD
# Pair of Fives
# 	 	2C 3S 8S 8D TD
# Pair of Eights
# 	 	Player 2
# 2	 	5D 8C 9S JS AC
# Highest card Ace
# 	 	2C 5C 7D 8S QH
# Highest card Queen
# 	 	Player 1
# 3	 	2D 9C AS AH AC
# Three Aces
# 	 	3D 6D 7D TD QD
# Flush with Diamonds
# 	 	Player 2
# 4	 	4D 6S 9H QH QC
# Pair of Queens
# Highest card Nine
# 	 	3D 6D 7H QD QS
# Pair of Queens
# Highest card Seven
# 	 	Player 1
# 5	 	2H 2D 4C 4D 4S
# Full House
# With Three Fours
# 	 	3C 3D 3S 9S 9D
# Full House
# with Three Threes
# 	 	Player 1

# The file, poker.txt, contains one-thousand random hands dealt to two 
# players. Each line of the file contains ten cards (separated by a 
# single space): the first five are Player 1's cards and the last 
# five are Player 2's cards. You can assume that all hands are valid 
# (no invalid characters or repeated cards), each player's hand is in 
# no specific order, and in each hand there is a clear winner.

# How many hands does Player 1 win?

# Answer taken from http://oxaric.wordpress.com/2008/11/24/euler-project-problem-54-solution/.

# By: Louis Casillas, oxaric@gmail.com

# Euler Problem #54
# How many hands does Player 1 win?
# The hands are in filename 'poker.txt' and the first 5 space delimited 
# values are for player 1's cards and the other 5 are for player 2's cards.

# card values: 2 to 10, Jack = 11, Queen = 12, King = 13, Ace = 14
# card suits: Hearts = 0, Diamonds = 1, Spades = 2, Clubs = 3

class Card
   attr_accessor :value, :suit

   def initialize( card )

      temp_value = card[0, 1]
      temp_suit = card[1, 1]
      
      temp_suit.downcase!

      if temp_suit == "h"
         temp_suit = "0"      
      else
         if temp_suit == "d"
            temp_suit = "1"
         else
            if temp_suit == "s"
               temp_suit = "2"
            else
               temp_suit = "3"
            end
         end
      end
         
      temp_value.downcase!
      
      if temp_value == "t"
         temp_value = "10"
      else
         if temp_value == "j"
            temp_value = "11"
         else
            if temp_value == "q"
               temp_value = "12"
            else
               if temp_value == "k"
                  temp_value = "13"
               else
                  if temp_value == "a"
                     temp_value = "14"
                  end
               end
            end
         end
      end

      @value = temp_value.to_i()
      @suit = temp_suit.to_i()
   end

   def <=>( other_card )
      @value <=> other_card.value
   end

   def eql?( other_card )
      @value == other_card.value
   end

   def hash
      [value].hash
   end

   def to_s
      @value.to_s() + @suit.to_s()
   end
end

class Hand
   def initialize( *cards )
      
      cards.flatten!      
      
      @cards = Array.new( cards.size )
            
      for i in (0...cards.size)
         @cards[i] = Card.new( cards[i] ) 
      end
   end
   
   def getValueHashTable
      value_hash_table = Array.new(15)         

      for i in (0..14)
         value_hash_table[i] = 0
      end
         
      for i in (0...@cards.size)
         card_value = @cards[i].value
         value_hash_table[ card_value ] += 1
      end

      value_hash_table
   end

   def getSuitHashTable
      suit_hash_table = Array.new(4)

      for i in (0..3)
         suit_hash_table[i] = 0
      end
         
      for i in (0...@cards.size)
         card_suit = @cards[i].suit
         suit_hash_table[ card_suit ] += 1
      end

      suit_hash_table
   end

   def whatIsTheHighest?
      test = isRoyalFlush?
      if test[0]
         return [23, test[1]]
      end

      test = isStraightFlush?
      if test[0]
         return [22, test[1]]
      end

      test = isFourOfAKind?
      if test[0]
         return [21, test[1]]
      end

      test = isFullHouse?
      if test[0]
         return [20, test[1], test[2]]
      end

      test = isFlush?
      if test[0]
         return [19, test[1]]
      end

      test = isStraight?
      if test[0]
         return [18, test[1]]
      end

      test = isThreeOfAKind?
      if test[0]
         return [17, test[1]]
      end

      test = isTwoPair?
      if test[0]
         return [16, test[1], test[2]]
      end

      test = isOnePair?
      if test[0]
         return [15, test[1]]
      end

      highestCardValue?
   end
   
   def isRoyalFlush?
      if isStraightFlush?[0]
         hash_value = getValueHashTable         
         
         is_royal = false
         
         for i in (10..14)
            if hash_value[ i ] > 0
               is_royal = true
            else
               return [false]
            end
         end
         
         if is_royal
            return [true, 14]
         end
      end

      [false]
   end

   def isStraightFlush?
      test1 = isFlush?
      test2 = isStraight?

      if test1[0] && test2[0]
         [true, test2[1]]
      else
         [false]
      end
   end

   def isFourOfAKind?
      value_table = getValueHashTable

      for i in (0..14)
         if value_table[i] >= 4
            return [true, i]
         end
      end

      [false]
   end

   def isFullHouse?
      test1 = isThreeOfAKind?
      test2 = isTwoPair?
      if test1[0] && test2[0]

         if test1[1] == test2[1]
            [true, test1[1], test2[2]]
         else
            [true, test1[1], test2[1]]
         end
      else
         [false]
      end
   end

   def isFlush?
      suit_hash = getSuitHashTable

      for i in (0..3)
         temp = suit_hash[i]         

         if temp == @cards.size
            return [true, highestCardValue?[0]]
         end

         break if (temp < @cards.size) && (temp != 0)
      end

      [false]
   end

   def isStraight?
      sorted_cards = @cards.sort
      
      card_value = sorted_cards[0].value

      for i in (1...@cards.size)
         if (card_value + 1) != sorted_cards[i].value
            return [false]
         end

         card_value += 1
      end

      [true, card_value]
   end

   def isThreeOfAKind?
      value_table = getValueHashTable

      for i in (0..14)
         if value_table[i] >= 3
            return [true, i]
         end
      end

      [false]
   end

   def isTwoPair?
      if isOnePair?[0]
         number_of_pairs = 0

         value_table = getValueHashTable
         
         first_pair_card = 0
         second_pair_card = 0

         for i in (0..14)
            if value_table[i] >= 2
               number_of_pairs += 1

               if number_of_pairs == 1
                  first_pair_card = i
               end

               if number_of_pairs == 2
                  second_pair_card = i
               end
            end
         end
         
         if number_of_pairs >= 2
            if first_pair_card > second_pair_card
               return [true, first_pair_card, second_pair_card]   
            else
               return [true, second_pair_card, first_pair_card]
            end
         else
            [false]
         end
      else
         [false]
      end
   end

   def isOnePair?
      value_table = getValueHashTable

      for i in (0..14)
         if value_table[i] >= 2
            return [true, i]
         end
      end
      
      [false]
   end

   def highestCardValue?
      sorted_cards = @cards.sort
      
      card_values = Array.new()
      
      for i in (0...@cards.size)
         card_values.insert( 0, sorted_cards[i].value )
      end

      card_values
   end

   def >( other_hand )
      
      my_hand = whatIsTheHighest?
      their_hand = other_hand.whatIsTheHighest?

      if my_hand[0] > their_hand[0]
         return true
      end
      
      if my_hand[0] < their_hand[0]
         return false
      end

      for i in (1...my_hand.size)
         if my_hand[i] > their_hand[i]
            return true
         end

         if my_hand[i] < their_hand[i]
            return false
         end
      end

      my_hand = highestCardValue?
      their_hand = other_hand.highestCardValue?

      for i in (0...my_hand.size)

         if my_hand[i] > their_hand[i]
            return true
         end

         if my_hand[i] < their_hand[i]
            return false
         end
      end

      nil
   end

   def <( other_hand )
      
      my_hand = whatIsTheHighest?
      their_hand = other_hand.whatIsTheHighest?

      if my_hand[0] > their_hand[0]
         return false
      end
      
      if my_hand[0] < their_hand[0]
         return true
      end

      for i in (1...my_hand.size)
         if my_hand[i] > their_hand[i]
            return true
         end

         if my_hand[i] < their_hand[i]
            return false
         end
      end
      
      my_hand = highestCardValue?
      their_hand = other_hand.highestCardValue?

      for i in (0...my_hand.size)

         if my_hand[i] > their_hand[i]
            return false
         end

         if my_hand[i] < their_hand[i]
            return true
         end
      end

      nil
   end

   def ==( other_hand )
      
      my_hand = whatIsTheHighest?
      their_hand = other_hand.whatIsTheHighest?
      
      for i in (0...my_hand.size)

         if my_hand[i] != their_hand[i]
            return false
         end
      end

      true
   end

   def to_s
      temp_s = ""
      
      for i in (0...@cards.size)
         temp_s += @cards[i].to_s + " "
      end

      temp_s
   end
end

file = File.new("poker.txt", "r")

temp_s = ""

total_wins_for_player1 = 0

while (line = file.gets)
   hands = line.split(" ")

   for i in (0..4)
      temp_s += hands[i] + " "
   end
puts
   puts temp_s
   player1_hand = Hand.new( temp_s.split( " " ) )
   
   temp_s = ""

   for i in (5..9)
      temp_s += hands[i] + " "
   end

   puts temp_s
   player2_hand = Hand.new( temp_s.split( " " ) )
puts   
   if player1_hand > player2_hand
      total_wins_for_player1 += 1
   end

   temp_s = ""
end

file.close

puts "Player 1 won: " + total_wins_for_player1.to_s + " times."

