class Card
	
	@@FACE_CARDS_AND_ACE = [:ace, :king, :queen, :jack]

	#To construct a new Card you must pass it both a suit and a value
	#2-9 or Ace, King, Queen, Jack
	def initialize(suit, value)
		@suit = suit;
		@value = value;
	end

	#Returns the numeric value of the card, face value for 2-9, 10 for 
	#face cards, and one and 11 for aces.
	def value
		return [@value] if not @@FACE_CARDS_AND_ACE.include? @value
		return [1, 11] if @value == :ace
		return [10]
	end

	#Returns a string representation of the card suitable for printing
	def to_s
		return @value.to_s + " of " + @suit.to_s
	end

	#Need a reader for suit as it can be passed back with no changes made,
	#value on the other hand involves some calculations so we need more than
	#the default.
	attr_reader :suit

end