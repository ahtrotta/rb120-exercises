class Transform
  def initialize(str)
    @str = str
  end

  def uppercase
    @str.upcase
  end

  def self.lowercase(input)
    input.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
