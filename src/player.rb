class Player

	#A player needs a name, and starts with no hands, no bets
	#and $1000 dollars
	def initialize(name)
		@name = name
		@money = 1000
		@hands = []
		@bets = []
	end

	#Adds a hand and a corresponding bet to a player
	def add_hand(hand, bet)
		@hands << hand
	end
	
	#Discards the player's hands and clears their bets
	def clear!
		@hands = []
		@bets = []
	end

	#Returns a string stating the player's name 
	#and their available money
	def to_s
		return name + ": $" + @money + " available." 
	end

	#Returns true if the bet the player is attempting to make
	#is less than or equal to the money the player has left
	#less all bets currently in play
	def valid_bet?(bet_attempt)
		return bet_attempt <= (@money - @bets.inject { |sum, bet| sum += bet})
	end

	attr_accessor :money, :hands, :bets
	attr_reader :name

end
