require File.dirname(__FILE__) +'/player.rb'

class HumanPlayer < Player

	#Human players need a name, start with no hands or 
	#current bets and $1000
	def initialize(name)
		@money = 1000
		@bets = []
		super(name)
	end

	#Clears the player's current bets and uses the clear! method
	#in the super class to clear their hands.
	def clear!
		@bets = []
		super
	end

	#Adds a hand and corresponding bet to the player
	def add_hand(hand, bet)
		@bets << bet
		super(hand)
	end
	
	#Returns a string stating the player's name 
	#and their available money
	def to_s
		return name + "\n$" + @money + " available." 
	end

	#Returns true if the bet the player is attempting to make
	#is less than or equal to the money the player has left
	#less all bets currently in play
	def valid_bet?(bet_attempt)
		return bet_attempt <= (@money - @bets.inject(0) { |sum, bet| sum += bet})
	end

	attr_accessor :money, :bets

end
