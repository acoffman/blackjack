##RSpec test for the Card Class

require '../src/card'

describe Card do

	it "should return face value for number cards" do
		for curr in (2..9)
			test_card = Card.new(:hearts, curr)
			test_card.value.should == [curr]
		end
	end

	it "should return both 1 and 11 for aces" do
		test_card = Card.new(:spades, :ace)
		test_card.value.should == [1,11]
	end

	it "should return 10 for face cards" do
		[:jack, :queen, :king].each do |curr|
			test_card = Card.new(:clubs, curr)
			test_card.value.should == [10]
		end
	end

	it "should return the same suit passed to it" do
		[:hearts, :clubs, :spades, :diamonds].each do |curr|
			test_card = Card.new(curr, 10)
			test_card.suit.should == curr
		end
	end

end

