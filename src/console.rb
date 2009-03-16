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
	def display_turn(player)
		divider
		puts "Current player: " + player.to_s
	end

	#Cycles through each player in the game and collects their bets
	#ignores the dealer which has no bet
	#This function also returns an array to the main program
	#to determine if a player wants to quit or not
	def get_bets(players)
		did_quit = []
		players.each do |current_player|
			if not current_player.is_a? Dealer
				bet = ""
				until is_integer?(bet) && Integer(bet) <= current_player.money && Integer(bet) > 0
					print "#{current_player.name} please enter an integer bet between 1 and #{current_player.money} or Q to quit: "
					bet = gets.chomp
					if bet.upcase[0..0] == "Q"
						did_quit << :quit
						break
					else
						did_quit << :no
						current_player.bets[0] = Integer(bet)
					end
				end
			end
		end
		divider
		return did_quit
	end

	#Displays the dealers face up card to the screen
	#Or if the round is over, displays the Dealer's entire hand
	def display_dealer(dealer, round_over)
		puts
		if round_over
			puts "Dealer: #{dealer.hands[0].to_s}"
		else
			puts "Dealer shows: #{dealer.face_up_card}"
		end
	end

	#Displays the players hand along with potential values to the screen
	def display_hand(hand)
		puts "You show: #{hand.to_s}\n"
	end

	#Displays the appropriate prompt for the given hand and returns the
	#result back to the main program
	#If the Player is a Dealer, it generates the response automatically
	#This function also checks to see what moves are valid before 
	#allowing the user to select them
	def prompt(hand_num,player)
			if player.is_a? Dealer
				return :hit if player.must_hit?
				return :stand
			end
			
			valid_choices = ["H","S"]
			puts "H: Hit"
			puts "S: Stand"
			if player.hands[hand_num].splitable? && player.valid_bet?(player.bets[hand_num])
				puts "P: Split"
				valid_choices << "P"
			end
			if player.valid_bet?(player.bets[hand_num])
				puts "D: Double Down"
				valid_choices << "D"
			end
			print "#{player.name}, please make a selection: "

			#By parsing choice this way, the user can enter
			#just the first letter, upper or lower case as well
			#as the entire word if they wish
			choice = gets.strip.upcase[0..0]
			until valid_choices.include?(choice)
				puts "Invalid selection, please try again: "
				choice = gets.strip.upcase[0..0]
			end
			#After we have a valid result, return the correct message to the
			#main program
			case choice
				when "H"
					return :hit
				when "S"
					return :stand
				when "P"
					return :split
				when "D"
					return :double
			end
	end
	
	#Clears the console window (unless your console is really really tall!)
	def clear_screen
		40.times {puts "\n"}
	end

	#Prints the result of a hand to the console
	def display_result(result,bet)
		case result
		when :lose
			puts "Hand loses, -$#{bet}"
		when :win
			puts "Hand wins, +$#{bet}"
		when :blackjack
			puts "Blackjack! Hand wins, +$#{Integer(1.5*bet)}"
		when :push
			puts "Push, no change."
		when :bust
			puts "Bust! Hand loses, -$#{bet}"
		end
	end
		
	#Defaults to 55 chars wide, but that could easily be 
	#changed if desired
	def divider
		puts
		55.times {print "-"}
		puts 
	end

	#Used to make sure that a string input is a valid integer	
	def is_integer?(input)
		return input =~ /^[0-9]+$/
	end

	#displays a given message to the screen
	def display_message(msg)
		puts msg
	end


	#Asks the user how many players would like to play
	#Then gets names, creates the players and adds them to the table
	def set_up_players
		num_players = ""

		until is_integer?(num_players) 
			puts "Please enter a non-zero integer value for the number of players."
			num_players = gets
		end 

		if num_players == "0\n"
			puts "You need at least one player, defaulting to one."
			num_players = 1
		end
		players = []
		Integer(num_players).times {|player_num| add_human_player(player_num+1,players)}
		return players
	end

	#Asks the player for a name or supplies a default value
	#if none is entered and adds the player to the players array at
	#the table
	def add_human_player(player_num,players)
		name = ""
		puts "Player #{player_num} please enter your name or hit enter for the default: "
		name = gets
		name = "Player #{player_num}" if name.strip! == ""
		players << HumanPlayer.new(name)
	end

end
