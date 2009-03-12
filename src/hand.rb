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
		return hand_value.min > 21	
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
		return values.uniq
	end

	#When taking a hit, you will need to add a card to your hand
	def add_card(card)
		@cards << card	
	end

	attr_reader :cards

end
