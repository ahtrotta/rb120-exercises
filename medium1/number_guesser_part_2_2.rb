class GuessingGame
  def initialize(low, high)
    @range = low..high
    @guesses_remaining = Math.log2(@range.size).to_i + 1
    @number = rand(@range)
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
      print "Enter a valid number between #{@range.first} and #{@range.last}: "
      @guess = gets.chomp.to_i
      next unless @range.cover?(@guess)
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


game = GuessingGame.new(501, 1500)
game.play
