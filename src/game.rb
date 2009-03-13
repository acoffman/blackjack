#This class is where the actual flow of play is controlled
#it requires every other class to function
%w(shoe player human_player dealer table card hand).each do |file|
	require File.dirname(__FILE__) + "/" + file	
end

class Game

	@@NUMBER_OF_DECKS_IN_A_SHOE = 4

	#Constructor starts a table for the game and sets up
	#a constant to represent the dealer
	def initialize
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
			#each player takes their turn
			@table.players.each do |current_player|
				take_turn current_player
			end
		
			#each player's winnings or loses are calculated after 
			@table.players.each do |current_player|
				calculate_winnings current_player

				#If this isn't the dealer and is out of money, drop from the game
				if current_player.is_a? HumanPlayer && current_player.money == 0
					puts "#{current_player.name} is out of money and cannot continue."
					@table.players.delete(current_player)
				end
			
				#If only the dealer remains, the game is over
				game_over = true if @table.players.length == 1
			end
		end
	end

	#play is the only publically accessable member besides the constructor
	#the rest of the functions are private helper functions
	private

	def take_turn(player)

	end

	def calculate_winnings(player)
	
	end

	def hand_winner?(hand)
		
	end

	def prompt(player,hand_num)
		prompt = player.to_s << "\n"
		prompt << "Select an option to continue:\n "
		prompt << "H: Hit\n"
		prompt << "S: Stand\n"
		prompt << "P: Split\n" if player.hands[hand_num].splitable?
		prompt << "D: Double Down\n" if player.money >= player.bets[hand_num]
		

		
	end

	def clear_screen
		50.times {puts "\n"}
	end

end
