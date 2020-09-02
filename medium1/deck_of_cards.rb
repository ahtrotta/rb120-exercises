class Card
  CARD_ORDER = (2..10).to_a + %w(Jack Queen King Ace)
  SUIT_ORDER = %w(Diamonds Clubs Hearts Spades)

  include Comparable

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    val = CARD_ORDER.index(self.rank) <=> CARD_ORDER.index(other.rank)
    return val if val == 1 || val == -1
    SUIT_ORDER.index(self.suit) <=> SUIT_ORDER.index(other.suit)
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = new_deck.shuffle
  end

  def draw
    self.deck = new_deck.shuffle if self.deck.empty?
    deck.pop
  end

  private

  attr_accessor :deck

  def new_deck
    RANKS.each_with_object([]) do |rank, arr|
      SUITS.each do |suit|
        arr << Card.new(rank, suit)
      end
    end
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
