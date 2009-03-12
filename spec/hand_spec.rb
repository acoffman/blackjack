#RSpec test for hand class

require '../src/card'
require '../src/hand'

describe Hand do

	before(:all) do
		@ace_card = Card.new(:heart, :ace)
		@face_card = Card.new(:spade, :jack)
		@number_card = Card.new(:diamond, 7)
	end

	it "should only return true for actual blackjacks" do
		#real blackjack should return true
		testHand = Hand.new([@ace_card,@face_card],false)
		testHand.blackjack?.should == true
		#21 off of a split does not count as a blackjack
		testHand = Hand.new([@ace_card, @face_card],true)
		testHand.blackjack?.should_not == true
		#if the cards do not add up to 21, it is not a blackjack
		testHand = Hand.new([@face_card, @number_card],false)
		testHand.blackjack?.should_not == true
		#if the cards add up to 21, but there are more than 2, it is not
		#a blackjack
		testHand = Hand.new([@number_card,@number_card,@number_card], false)
		testHand.blackjack?.should_not == true
	end

	it "should only bust hands where all possible values exceed 21" do
		#No possible values are over 21, should not be a bust
		testHand = Hand.new([@ace_card,@face_card],false)
		testHand.bust?.should_not == true
		#Some values are bust, but others are not should not be a bust
		testHand.add_card(@ace_card)
		testHand.bust?.should_not == true
		#All possible values are over 21 should return true
		testHand.add_card(@face_card)
		testHand.bust?.should == true
	end

	it "should only allow splits when you have two cards that are equal" do
		#Two cards of equal value, should be a valid split
		testHand = Hand.new([@face_card,@face_card],false)
		testHand.splitable?.should == true
		#Three cards of equal value, should not be a valid split
		testHand.add_card(@face_card)
		testHand.splitable?.should_not == true
		#Two non-equal cards should not be splitable
		testHand = Hand.new([@face_card, @number_card],false)
		testHand.splitable?.should_not == true
	end

	it "should increase the value of the hand when a card is added" do
		testHand = Hand.new([@face_card, @ace_card],false)
		before_value = testHand.hand_value

		testHand.add_card(@number_card)
		testHand.hand_value[0].should == before_value[0] + @number_card.value[0]
	end

	it "should correctly calculate the value of the hand" do
		#Ace and a Face card
		testHand = Hand.new([@face_card, @ace_card],false)
		testHand.hand_value.should == [11,21]
		#Ace, face card, and number card
		testHand.add_card(@number_card)
		testHand.hand_value.should == [18,28]
	end

end
