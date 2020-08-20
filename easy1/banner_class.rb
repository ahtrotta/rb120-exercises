#class Banner
#  def initialize(message)
#    @message = message
#  end
#
#  def to_s
#    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#  end
#
#  private
#
#  def horizontal_rule
#    '+-' + '-' * @message.length + '-+'
#  end
#
#  def empty_line
#    '| ' + ' ' * @message.length + ' |'
#  end
#
#  def message_line
#    "| #{@message} |"
#  end
#end
#
#banner = Banner.new('To boldly go where no one has gone before.')
#puts banner
#
#banner = Banner.new('')
#puts banner
#
#
# FURTHER EXPLORATION
#
# problem
#   - modify Banner class so that the new method will optionally let you specify a fixed banner width at creation
#
# data structure
#   - store message in array with each line as a separate string object
#   - make all functionality private in class except to_s
#
# message split algorithm
#   - split input str on space
#   - initialize lines array (will be returned)
#   - initialize line to empty string
#   - call shift on array of words until it returns nil
#     - if curr_word length plus length of line is greater than width
#       - add line to lines
#       - set line to curr_word
#     - else 
#       - add a space and curr_word to line
#   - return lines
#
# to_s algorithm
#   - [horizontal_rule, empty_line] + message_lines + [empty_line, horizontal_rule].join("\n")

class Banner
  def initialize(message, width = (message.length + 4))
    @message = message

    if message.empty?
      @width = 0
    elsif width > 80 
      @width = 76
    else
      longest = message.split.max_by(&:length).length

      if width < longest
        @width = longest
      else
        @width = width - 4
      end
    end
  end

  def to_s
    buff = [horizontal_rule, empty_line]
    (buff + message_lines + buff.reverse).join("\n")
  end

  private

  def split_message(message, width)
    words = message.split
    lines = []
    line = ''

    until !(word = words.shift)
      if line.length + word.length + 1 > width
        lines << line
        line = word
      elsif line.empty?
        line << word
      else
        line << ' ' << word
      end
      lines << line if words.empty?
    end

    lines
  end

  def horizontal_rule
    '+-' + '-' * @width + '-+'
  end

  def empty_line
    '| ' + ' ' * @width + ' |'
  end

  def message_lines
    split_message(@message, @width).map { |line| "| #{line.center(@width)} |" }
  end
end

# test cases

banner = Banner.new("To boldly go where no one has gone before.")
puts banner

banner = Banner.new("To boldly go where no one has gone before.", 80)
puts banner

banner = Banner.new('')
puts banner

banner = Banner.new("To boldly go where no one has gone before.", 0)
puts banner

banner = Banner.new('Here is a really long message to put inside of the banner to test whether it works correctly. It has two sentences.', 50)
puts banner

=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
+------------------------------------------------------------------------------+
|                                                                              |
|                  To boldly go where no one has gone before.                  |
|                                                                              |
+------------------------------------------------------------------------------+
+--+
|  |
|  |
+--+
+---------+
|         |
|   To    |
| boldly  |
|   go    |
|  where  |
| no one  |
|   has   |
|  gone   |
| before. |
|         |
+---------+
+------------------------------------------------+
|                                                |
| Here is a really long message to put inside of |
| the banner to test whether it works correctly. |
|             It has two sentences.              |
|                                                |
+------------------------------------------------+
=end

