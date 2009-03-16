class Hand
	
	#A hand needs to consist of at least two cards. More can be added later
	#but an array of two cards needs to be passed to the constructor to start.
	#Additionally, the hand needs to know if it is the result of a split
	#because if it is, a 21 cannot result in a blackjack.
	def initialize(cards, from_split)
		@cards = cards
		@from_split = from_split
	end

	#Is the hand over 21, even its minimum value (if aces)
	def bust?
		return hand_value.length == 0	
	end

	#If only two cards are dealt, the hand does not result from a split
	#and the cards total up to 21, then we have a blackjack.
	def blackjack?
		return @cards.length == 2 && !@from_split && hand_value.include?(21)
	end

	#Returns true if the hand is eligible to be split.
	#ie are there only two cards and do they have the same 
	#value?
	def splitable?
		return @cards.length == 2 && @cards[0].value == @cards[1].value
	end

	#Returns the numeric value of the hand as a one element array
	#or a multi element array if more than one possible value.
	def hand_value
		values = [0]

		@cards.each do |current_card|
			current_values = []
			current_card.value.each do |current_value|
				#needed to allow for aces having two possible values
				current_values += values.collect {|x| x + current_value}
			end
			values = current_values
		end
		#exclude duplicate values in the case of multiple aces
		#as well as values over 21
		return values.uniq.reject{|x| x > 21}
	end

	#When taking a hit, you will need to add a card to your hand
	def add_card(card)
		@cards << card	
	end

	#Prints out the player's hand as a string, and then the numeric
	#value of the hand (or bust if it is)
	def to_s
		string_val = ""
		@cards.each do |current_card|
			string_val << current_card.to_s
			string_val << ", "
		end
		if hand_value.length == 0
			string_val << "BUST"
		else
			string_val << "(" + hand_value.join(",") + ")"
		end
		return string_val
	end

	#Convenience method so that you can get the card at
	#position i in the hand without accessing the cards array
	#directly
	def [](index)
		return cards[index]
	end

	#Allows cards in the player's hand to be reassigned.
	#Used primarily for splits
	def []=(index, card)
		@cards[index] = card
	end

	attr_reader :cards

end
