class Cat
  COLOR = 'purple'

  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def greet
    "Hello! My name is #{name} and I'm a #{COLOR} cat!"
  end
end

kitty = Cat.new('Sophie')
p kitty.greet
