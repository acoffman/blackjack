#Rspec test for the generic player super-class

require File.dirname(__FILE__) +'/../src/player'
require File.dirname(__FILE__) +'/../src/hand'
require File.dirname(__FILE__) +'/../src/card'

describe Player do
	
	before(:all) do
		@test_player = Player.new("Fred")
		@test_hand = Hand.new([Card.new(:heart, :ace), Card.new(:spade, :queen)], false)
	end

	it "should start off with no hands" do
		@test_player.hands.length.should == 0
	end

	it "should add hands correctly" do
		@test_player.add_hand(@test_hand)
		@test_player.hands.length.should == 1
		@test_player.add_hand(@test_hand)
		@test_player.hands.length.should == 2
	end

	it "should remove all hands when cleared" do
		@test_player.clear!
		@test_player.hands.length.should == 0
	end

	it "should set the name as passed to the constructor" do
		@test_player.name.should == "Fred"
	end

end
