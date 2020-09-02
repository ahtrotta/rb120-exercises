class GuessingGame
  def initialize(low, high)
    @range = low..high
    @number = nil
    @guess = nil
    @remaining_guesses = nil
  end

  def play
    reset
    loop do
      display_remaining_guesses
      make_guess
      display_guess_result
      break if self.number == self.guess || remaining_guesses.zero?
    end
    display_game_result
  end

  private

  attr_accessor :number, :guess, :remaining_guesses, :range 

  def reset
    @number = rand(self.range)
    @guess = nil
    @remaining_guesses = Math.log2(self.range.size).to_i + 1
  end

  def display_remaining_guesses
    if self.remaining_guesses == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{remaining_guesses} guesses remaining."
    end
  end

  def make_guess
    loop do
      print "Enter a number between #{self.range.begin} and #{self.range.end}: "
      self.guess = gets.chomp.to_i
      break if self.range.member?(guess)
      print "Invalid guess. "
    end
    self.remaining_guesses -= 1
  end

  def display_guess_result
    if self.guess > self.number
      puts "Your guess is too high."
    elsif self.guess < self.number
      puts "Your guess is too low."
    else
      puts "That's the number!"
    end
    puts ''
  end

  def display_game_result
    if self.number == self.guess 
      puts "\nYou won!"
    else
      puts "\nYou have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new(501, 1500)
game.play
