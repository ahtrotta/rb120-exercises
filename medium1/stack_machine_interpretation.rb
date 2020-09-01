class Minilang
  def initialize(commands)
    @commands = commands.downcase.split
    @register = 0
    @stack = []
  end

  def eval
    @commands.each do |cmd|
      if integer?(cmd)
        @register = cmd.to_i
      else

        begin
          send(cmd.to_s)
        rescue NoMethodError
          puts "Invalid command, execution stopped."
          break
        end

      end
    end
  end

  private

  def integer?(value)
    Float(value)
    true
  rescue ArgumentError
    false
  end

  def push
    @stack.push(@register)
  end

  def add
    @register += @stack.pop
  end

  def sub
    @register -= @stack.pop
  end

  def mult
    @register *= @stack.pop
  end

  def div
    @register /= @stack.pop
  end

  def mod
    @register %= @stack.pop
  end

  def pop
    @register = @stack.pop
  end

  def print
    puts @register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
