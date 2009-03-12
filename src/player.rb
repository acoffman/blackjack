class Player

	#A player needs a name, and starts with no hands
	def initialize(name)
		@name = name
		@hands = []
	end

	#Adds a hand to the player 
	def add_hand(hand)
		@hands << hand
	end
	
	#Discards the player's hands
	def clear!
		@hands = []
	end

	attr_accessor :hands 
	attr_reader :name

end
