#Rspec test for the Dealer sub class of Player

require File.dirname(__FILE__) + '/../src/dealer'
require File.dirname(__FILE__) + '/../src/hand'
require File.dirname(__FILE__) + '/../src/card'

describe Dealer do

	before(:all) do
		@test_dealer = Dealer.new
		@hit_hand = Hand.new([Card.new(:hearts,:ace), Card.new(:spades, 6)], false)
		@stand_hand = Hand.new([Card.new(:hearts, :ace),Card.new(:hearts, :king)],false)
		@hit_hand2 = Hand.new([Card.new(:hearts, :ace), Card.new(:spades, :ace), Card.new(:clubs, 5)],false)
		@stand_hand2 = Hand.new([Card.new(:hearts, 10), Card.new(:hearts, 8)],false)
		@bust_hand = Hand.new([Card.new(:hearts, 10), Card.new(:hearts, 8), Card.new(:hearts,7)],false)

	end

	it "should hit soft hands 17 and under, and stand otherwise" do
		@test_dealer.add_hand(@hit_hand)
		@test_dealer.must_hit?.should == true
		
		@test_dealer.clear!
		@test_dealer.add_hand(@hit_hand2)
		@test_dealer.must_hit?.should == true

		@test_dealer.clear!
		@test_dealer.add_hand(@stand_hand)
		@test_dealer.must_hit?.should_not == true

		@test_dealer.clear!
		@test_dealer.add_hand(@stand_hand2)
		@test_dealer.must_hit?.should_not == true

		@test_dealer.clear!
		@test_dealer.add_hand(@bust_hand)
		@test_dealer.must_hit?.should_not == true
	end

	it "should return a \"Card\" clase when face_up_card is called" do
		@test_dealer.face_up_card.class.should == Card
	end

end


