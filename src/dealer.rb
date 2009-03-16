require File.dirname(__FILE__) + '/player'

class Dealer < Player

	#The dealer is called "Dealer" no name is needed.
	#the dealer has no money or bets
	def initialize
		super("Dealer")
	end

	#The dealer must hit a 16 or soft 17 and stand on
	#a hard 17 or higher
	def must_hit?
		#hand is a bust - stand
		return false if @hands[0].hand_value.length == 0
		#dealer has a hand with a possible value over 17 - stand
		return false if @hands[0].hand_value.max > 17 
		#dealer has a hand with no values over 17 - hit
		return true if @hands[0].hand_value.max < 17
		#dealer has a possible 17, but it is soft - hit
		return true if @hands[0].hand_value.length > 1 && @hands[0].hand_value.max == 17
		#dealer has a 17 that isnt soft - stand
		return false
	end

	#Only one of the Dealer's cards should be shown at first
	#this method returns the second card in the dealer's hand
	#to be displayed
	def face_up_card
		return @hands[0][1]
	end

	#The dealer will only ever have one hand, so this method cleans up
	#the code in the other classes. Eliminates the need to type
	#@DEALER.hands[0] 
	def hand
		return @hands[0]
	end

	#Returns the string "dealer" 
	#move along..nothing to see here...
	def to_s
		return "Dealer"
	end

end
