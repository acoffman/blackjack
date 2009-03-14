%w(shoe player human_player dealer table card hand).each do |file|
	require File.dirname(__FILE__) + "/" + file	
end

#This module contains the IO methods that deal
#with requesting and recieving information
#from the users. It processes it and sends it 
#back to the main program in a usable form.
#This module is also responsible for ensuring the
#values passed back are valid in the context of the game
module Console

	#States the current player and their available
	#money using the overidden to_s method in the player class
	def say_turn(player)
		divider
		puts "Current player: " + player.to_s
	end

	#Cycles through each player in the game and collects their bets
	#ignores the dealer which has no bet
	def get_bets(players)
		players.each do |current_player|
			if not current_player.is_a? Dealer
				bet = ""
				until is_integer?(bet) && Integer(bet) <= current_player.money && Integer(bet) > 0
					print "#{current_player.name} please enter an integer bet between 1 and #{current_player.money}: "
					bet = gets.chomp
				end
				current_player.bets[0] = Integer(bet)
			end
		end
		divider
	end

	#Displays the dealers face up card to the screen
	def display_dealer(dealer)
		puts
		puts "Dealer shows: #{dealer.face_up_card}" 
	end

	#Displays the players hand along with potential values to the screen
	def display_hand(hand)
		puts "You show: #{hand.to_s}"
	end

	#Displays the appropriate prompt for the given hand and returns the
	#result back to the main program
	def prompt(hand)
			
	end
	
	#Clears the console window (unless your console is really really tall!)
	def clear_screen
		40.times {puts "\n"}
	end

	#Prints the result of a hand to the console
	def print_result(result,bet)
		case result
		when :lose
			puts "Hand loses, -$#{bet}"
		when :win
			puts "Hand wins, +$#{bet}"
		when :blackjack
			puts "Blackjack! Hand wins, +$#{Integer(1.5*bet)}"
		when :push
			puts "Push, no change."
		end
	end
		
	#Defaults to 80 chars wide, as that is the default console
	#width on a mac, but this can be easily modified
	def divider
		puts
		80.times {print "-"}
		puts 
	end

	#Used to make sure that a string input is a valid integer	
	def is_integer?(input)
		return input =~ /^[0-9]+$/
	end

end
