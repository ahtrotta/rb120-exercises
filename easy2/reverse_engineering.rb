class Transform
  attr_accessor :data

  def initialize(input)
    self.data = input
  end
  
  def uppercase
    data.upcase
  end

  def self.lowercase(string)
    string.downcase
  end
end


my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
