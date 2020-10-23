class GuessingGame
  GUESSES = 7
  RANGE = (1..100).to_a

  def initialize
    @guesses_remaining = GUESSES
    @number = RANGE.sample
    @guess = nil
  end

  def play
    outcome = nil

    until @guesses_remaining == 0
      make_guess
      @guesses_remaining -= 1
      outcome = guess_number?
      break if outcome || @guesses_remaining == 0 
    end

    display_result(outcome)
  end

  private

  def make_guess
    puts "You have #{@guesses_remaining} guesses remaining."
    loop do
      print "Enter a valid number between #{RANGE.first} and #{RANGE.last}: "
      @guess = gets.chomp.to_i
      next unless RANGE.include?(@guess)
      break
    end
    nil
  end

  def guess_number?
    if @guess == @number
      puts "That's the number!"
      puts ''
      true
    else
      if @guess > @number
        puts "Your guess is too high."
      else
        puts "Your guess is too low."
      end
      puts ''
      false
    end
  end

  def display_result(outcome)
    if outcome
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new
game.play
