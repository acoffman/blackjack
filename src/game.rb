#This class is where the actual flow of play is controlled
#it requires every other class to function
%w(shoe player human_player dealer table card hand console).each do |file|
	require File.dirname(__FILE__) + "/" + file	
end

include Console

#The Game class controls the flow of gameplay for a 
#Table object.
class Game

	@@NUMBER_OF_DECKS_IN_A_SHOE = 6

	#Constructor starts a table for the game and sets up
	#a constant to represent the dealer
	def initialize
		Console::clear_screen
		Console::divider
		Console::display_message("Welcome to Adam Coffman's Blackjack! \nPrepared for Rapleaf!")
		@table = Table.new(@@NUMBER_OF_DECKS_IN_A_SHOE)
		@DEALER = @table.players[@table.players.length-1]
	end

	#Invoke the play function to start the game
	#it calls many smaller helper functions to control 
	#game flow
	def play	
		game_over = false

		#game continues until all players have run out of money
		#or left
		until game_over

			deal_round

			 if !@DEALER.hand.blackjack?
		  	#each player takes their turn
				@table.players.each do |current_player|
					take_turn current_player
				end
				Console::clear_screen
			 else
				 Console::display_message("Dealer Blackjack!")
			end

			Console::display_dealer(@DEALER,true)
		
			#each player's winnings or loses are calculated after 
			@table.players.each do |current_player|
				calculate_winnings(current_player) unless current_player.is_a? Dealer
				
				current_player.clear!

				#If this isn't the dealer and is out of money, drop from the game
				if current_player.is_a?(HumanPlayer) && current_player.money == 0
					Console::display_message("#{current_player.name} is out of money and cannot continue.")
					@table.players.delete(current_player)
				end

			end
				#If only the dealer remains, the game is over
				game_over = true if @table.players.length == 1
		end
		Console::divider
		Console::display_message("Thanks for playing!")
	end

	#play is the only publically accessable member besides the constructor
	#the rest of the functions are private helper functions
	private

	#Using the console module to collect user responses, the method
	#facilitates the player taking his turn, continuing until
	#the player stands, busts, or doubles down
	def take_turn(player)
		Console::divider
		Console::display_turn(player) unless player.is_a? Dealer
		player.hands.each_with_index do |current_hand,i|
			choice = ""
			until [:stand, :double, :bust].include? choice
				Console::display_dealer(@DEALER,false) unless player.is_a? Dealer
				Console::display_hand(current_hand) unless player.is_a? Dealer
				choice = Console::prompt(i, player)
				case choice		
					when :hit
						current_hand.add_card(@table.shoe.draw_card)
					when :split
						player.add_hand(Hand.new([current_hand[1], @table.shoe.draw_card], true),player.bets[i])
						current_hand[1] = @table.shoe.draw_card
					when :double
						current_hand.add_card(@table.shoe.draw_card)
						player.bets[i] = player.bets[i] * 2
						player.money -= player.bets[i]
						Console::display_hand(current_hand)
				end
				if (current_hand.bust? && player.is_a?(HumanPlayer))
					choice = :bust
					Console::display_message("Bust!")
				end
			end
		end
	end

	#Calculates the appropriate payouts for each player
	def calculate_winnings(player)
		Console::display_turn(player)
		player.hands.each_with_index do |current_hand, i|
			Console::display_hand(current_hand)
			result =""
		
			#The money bet is already removed from the player's
			#total available funds, so for wins we need to return
			#the money, plus whatever the payout is
			#for loses, we just don't re-add the bet
			if current_hand.bust?
				result = :bust
			elsif is_winner?(current_hand)
				if current_hand.blackjack?
					player.money += Integer(2.5 * player.bets[i])
					result = :blackjack
				else
					player.money += 2 * player.bets[i]
					result = :win
				end
			elsif is_push?(current_hand)
				player.money += player.bets[i]
				result = :push
			else
				result = :lose
			end
			Console::display_result(result, player.bets[i])
		end
		Console::divider
	end

	#Compares the hand to the dealer's hand to determine if it 
	#is a winner
	def is_winner?(hand)
		return true if !hand.bust? && @DEALER.hand.bust?
		return hand.hand_value.max > @DEALER.hand.hand_value.max
	end
	
	#Compares the hand to the dealer's hand to determine if it
	#is a push
	def is_push?(hand)
		return hand.hand_value.max == @DEALER.hand.hand_value.max
	end
	
	#Uses the console module to get each player's bets
	#and then deals a hand to each player.
	#this function also removes players if they want to
	#quit
	def deal_round
		
		did_quit = Console::get_bets(@table.players)

		@table.players.each_with_index do |player, i|
			@table.players.delete(player) if did_quit[i] == :quit
		end
		@table.deal
		Console::clear_screen
	end

end
