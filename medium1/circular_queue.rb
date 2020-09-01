require 'pry'

#class FixedArray
#  def initialize(size)
#    @array = [nil] * size
#  end
#
#  def [](index)
#    array.fetch(index)
#  end
#
#  def []=(index, new_val)
#    if index < array.size
#      array[index] = new_val
#    else
#      raise IndexError
#    end
#  end
#
#  def to_a
#    array.map(&:dup)
#  end
#
#  def to_s
#    array.inspect
#  end
#
#  private
#
#  attr_accessor :array
#end
#
#class CircularQueue < FixedArray
#  def initialize(size)
#    super
#    @current_index = 0
#    @size = size
#  end
#
#  def enqueue(val)
#    self.[]=(@current_index, val)
#    @current_index = (@current_index + 1) % @size
#    val
#  end
#
#  def dequeue
#    index = @current_index
#    ret_val = nil
#
#    if empty?
#      ret_val
#    elsif full?
#      ret_val = self.[]((index ) % @size)
#      self.[]=(((index ) % @size), nil)
#    else
#      loop do
#        index = (index - 1) % @size
#        break if self.[](index).nil?
#      end
#      ret_val = self.[]((index + 1) % @size)
#      self.[]=(((index + 1) % @size), nil)
#    end
#    ret_val
#  end
#
#  private :[], :[]=
#
#  def full?
#    array.none?(&:nil?)
#  end
#
#  def empty?
#    array.all?(&:nil?)
#  end
#end

class CircularQueue
  def initialize(size)
    @array = []
    @size = size
  end
  
  def enqueue(value)
    @array.shift if @array.size == @size
    @array.push(value)
  end

  def dequeue
    @array.shift
  end
end


queue = CircularQueue.new(3)
puts queue.dequeue == nil


queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
