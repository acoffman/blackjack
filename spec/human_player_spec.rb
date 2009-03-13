#RSpec test for the Human Player class, which is a descendent of 
#the Player class
require '../src/human_player'
require '../src/card'
require '../src/hand'

describe HumanPlayer do

	before(:all) do
		@test_player = HumanPlayer.new("Frank")
		@test_hand = Hand.new([Card.new(:hearts,10),Card.new(:spades,:king)],false)
	end

	it "should start with $1000 and be able to add and substract money" do
		@test_player.money.should == 1000
		lambda {@test_player.money += 50}.should change(@test_player, :money).by(50)
		lambda {@test_player.money -= 50}.should change(@test_player, :money).by(-50)
	end

	it "should only allow the player to bet as much money as he has" do
		@test_player.valid_bet?(500).should == true
		@test_player.valid_bet?(1005).should_not == true
		
		@test_player.add_hand(@test_hand,500)
		@test_player.valid_bet?(500).should == true
		@test_player.valid_bet?(1000).should_not == true
	end

	it "should remove in play bets and hands when it is cleared" do
		#we added a hand and corresponding bet in the previous test
		(@test_player.hands.length + @test_player.bets.length).should == 2
		@test_player.clear!
		(@test_player.hands.length + @test_player.bets.length).should == 0
	end

end


