class Shoe

	@@VALUES = [2,3,4,5,6,7,8,9,10,:jack,:queen,:king,:ace]
	@@SUITS = [:hearts,:spades,:clubs,:diamonds]

	#create a shoe with the desired number of decks
	#and shuffle the cards into random order
	def initialize(number_of_decks)
		@cards = []
		number_of_decks.times do
			@@VALUES.each do |current_value|
				@@SUITS.each do |current_suit|
					@cards << Card.new(current_suit, current_value)
				end
			end
		end

		#shuffle the decks together, will be nlogn time
		@cards.sort_by{rand}
	end

	#returns the top card (actually technically the last element in the array)
	#and removes it from the shoe
	def draw_card
		return @cards.pop
	end

	#returns the number of cards remaining in the shoe
	#so we can tell if it is time for a new shoe
	def check_remaining_cards
		return @cards.length
	end

end
