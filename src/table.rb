%w(shoe player human_player dealer hand console).each do |file|
	require File.dirname(__FILE__) + "/" + file	
end

include Console

#The table class represents and stores information pertaining to the
#"table" of blackjack, including the shoe, the current players and the
#dealer. 
class Table
	
	def initialize(number_of_decks)
		@shoe = Shoe.new(number_of_decks)
		@num_decks = number_of_decks
		@players = Console::set_up_players
		add_dealer
		Console::clear_screen
		Console::divider
	end

	#This method deals cards to each player, making sure that the shoe
	#is not running low on cards first
	def deal(bets)
		#This should be a fairly safe limit as to how many cards
		#will be left in the shoe when we reshuffle, but it could
		#be easily changed if needed
 		if @shoe.check_remaining_cards < 6 * @players.length
			@shoe = Shoe.new(@num_decks)
		end

		 @players.each do |current_player|
			 if current_player.is_a? HumanPlayer
		 		current_player.add_hand(Hand.new([@shoe.draw_card,@shoe.draw_card],false),current_player.bets[0])
			 else
				 current_player.add_hand(Hand.new([@shoe.draw_card,@shoe.draw_card],false))
			 end
		 end
	end

	#Adds a dealer type of "Player" to the array of players at the
	#table. called after all players are added to ensure the dealer always
	#goes last
	def add_dealer
		@players << Dealer.new
	end

	#no one needs to use this method externally
	private :add_dealer 

	attr_accessor :players, :shoe

end

