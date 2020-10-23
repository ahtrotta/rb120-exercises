require 'pry'

class Card
  include Comparable

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @val = get_val
  end

  def <=>(other)
    val <=> other.val
  end

  def to_s
    "#{rank} of #{suit}"
  end

  protected
  
  attr_reader :val

  def get_val
    case @rank
    when 'Ace'    then 14
    when 'King'   then 13
    when 'Queen'  then 12
    when 'Jack'   then 11
    when 2..10    then @rank
    end
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  
  def initialize
    @deck = new_deck.shuffle
  end

  def draw
    @deck = new_deck.shuffle if @deck.empty?
    @deck.pop
  end

  private

  def new_deck
    SUITS.each_with_object([]) do |suit, deck|
      RANKS.each do |rank|
        deck << Card.new(rank, suit)
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
