%w(shoe player human_player dealer table card hand).each do |file|
	require File.dirname(__FILE__) + "/" + file	
end

module Console

	def say_turn(player)
		divder
		puts "Current player: " + player.to_s
	end

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
	end


	def prompt(hand)
	
	end

	def clear_screen
		40.times {puts "\n"}
	end

	def print_result(result,bet)
		
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
