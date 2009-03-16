#This is the driver for the black jack game
require File.dirname(__FILE__) +"/src/game"

puts "Welcome to Adam Coffman's Blackjack! \nPrepared for Rapleaf\n"

blackjack_game = Game.new

blackjack_game.play

puts "Thanks for playing!\n"
