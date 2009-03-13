#RSpec test for the Shoe class

require File.dirname(__FILE__) +'/../src/shoe'
require File.dirname(__FILE__) +'/../src/card'

describe Shoe do

	before(:each) do
		@test_shoe = Shoe.new(4)
	end

	it "should have 52 times the number of decks cards" do
		@test_shoe.check_remaining_cards.should == 4*52
	end

	it "should remove a card from the deck when it draws one" do
		num_cards_before = @test_shoe.check_remaining_cards
		@test_shoe.draw_card
		@test_shoe.check_remaining_cards.should == num_cards_before -1
	end

	it "should return a Card object when you draw" do
		@test_shoe.draw_card.class.should == Card
	end

end
