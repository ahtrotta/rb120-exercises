# class FixedArray
#   - needs 
#     - initialize method that takes number of elements in array as arg
#       - create an array of that many elements initialized to nil
#     - need a getter method and setter method using []
#     - need a to_s method that just converts the array to a string

class FixedArray
  def initialize(size)
    @array = [nil] * size
  end

  def [](index)
    array.fetch(index)
  end

  def []=(index, new_val)
    if index < array.size
      array[index] = new_val
    else
      raise IndexError
    end
  end

  def to_a
    array.map(&:dup)
  end

  def to_s
    array.inspect
  end

  private

  attr_accessor :array
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end
