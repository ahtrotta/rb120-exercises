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
    val = CARD_ORDER.index(rank) <=> CARD_ORDER.index(other.rank)
    return val if val == 1 || val == -1
    SUIT_ORDER.index(suit) <=> SUIT_ORDER.index(other.suit)
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
    self.deck = new_deck.shuffle if deck.empty?
    deck.pop
  end

  def self.possible_straights(hand_size)
    (0..(RANKS.size - hand_size)).each_with_object([]) do |i, arr|
      arr << RANKS[i, hand_size]
    end
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

class PokerHand
  HAND_SIZE = 5

  def initialize(deck)
    @hand = draw_hand(deck).sort
    @straights = Deck.possible_straights(HAND_SIZE)
  end

  def print
    puts hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  attr_accessor :hand, :straights

  def draw_hand(deck)
    (1..HAND_SIZE).map do |_|
      deck.draw
    end
  end

  def hand_ranks
    hand.map(&:rank)
  end

  def hand_suits
    hand.map(&:suit).sort
  end

  def royal_flush?
    flush? && hand_ranks == straights.last
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    hand_ranks.uniq.any? { |rank| hand_ranks.count(rank) == 4 }
  end

  def full_house?
    hand_ranks.uniq.size == 2 && three_of_a_kind?
  end

  def flush?
    hand_suits.uniq.size == 1
  end

  def straight?
    straights.include?(hand_ranks)
  end

  def three_of_a_kind?
    hand_ranks.uniq.any? { |rank| hand_ranks.count(rank) == 3 }
  end

  def two_pair?
    hand_ranks.uniq.map { |rank| hand_ranks.count(rank) }.count(2) == 2
  end

  def pair?
    hand_ranks.uniq.any? { |rank| hand_ranks.count(rank) == 2 }
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
