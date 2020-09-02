class GuessingGame
  LOWER_LIMIT = 1
  UPPER_LIMIT = 100
  NUMBER_OF_GUESSES = 7

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

  attr_accessor :number, :guess, :remaining_guesses

  def reset
    @number = rand(LOWER_LIMIT..UPPER_LIMIT)
    @guess = nil
    @remaining_guesses = NUMBER_OF_GUESSES
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
      print "Enter a number between #{LOWER_LIMIT} and #{UPPER_LIMIT}: "
      self.guess = gets.chomp.to_i
      break if (LOWER_LIMIT..UPPER_LIMIT).member?(guess)
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
  end

  def display_game_result
    if self.remaining_guesses.zero?
      puts "\nYou have no more guesses. You lost!"
    else
      puts "\nYou won!"
    end
  end
end

game = GuessingGame.new
game.play
