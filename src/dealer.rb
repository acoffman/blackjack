require File.dirname(__FILE__) + '/player.rb'

class Dealer < Player

	#The dealer is called "Dealer" no name is needed.
	#the dealer has no money or bets
	def initialize
		super("Dealer")
	end

	#The dealer must hit a 16 or soft 17 and stand on
	#a hard 17 or higher
	def must_hit?
		#weed out bust values
		valid_values = @hands[0].hand_value.reject {|x| x > 21}
		#dealer has a hand with a possible value over 17 - stand
		return false if valid_values.max > 17 
		#dealer has a hand with no values over 17 - hit
		return true if valid_values.max < 17
		#dealer has a possible 17, but it is soft - hit
		return true if valid_values.length > 1 && valid_values.max == 17
		#dealer has a 17 that isnt soft - stand
		return false
	end

	#Only one of the Dealer's cards should be shown
	#this method returns the second card in the dealer's hand
	#to be displayed
	def face_up_card
		return @hands[0][1]
	end

	def to_s
		return "Dealer"
	end

end