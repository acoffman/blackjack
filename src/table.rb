%w(shoe player human_player dealer).each do |file|
	require File.dirname(__FILE__) + "/" + file	
end

class Table
	
	def initialize(number_of_decks)
		@shoe = Shoe.new(number_of_decks)
		@players = []
		set_up_players
		add_dealer
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

		Integer(num_players).times {|player_num| add_human_player(player_num+1)}
	end

	#Asks the player for a name or supplies a default value
	#if none is entered and adds the player to the players array at
	#the table
	def add_human_player(player_num)
		name = ""
		puts "Player #{player_num} please enter your name or hit enter for the default: "
		name = gets
		name = "Player #{player_num}" if name.strip! == ""
		@players << HumanPlayer.new(name)
	end

	#Adds a dealer type of "Player" to the array of players at the
	#table. called after all players are added to ensure the dealer always
	#goes last
	def add_dealer
		@players << Dealer.new
	end

	#Used to make sure that a string input is a valid integer
	def is_integer?(input)
		return input =~ /^[0-9]+$/
	end

	#no one needs to use these methods externally
	private :is_integer?, :add_dealer, :add_human_player, :set_up_players

	attr_accessor :players, :shoe

end

