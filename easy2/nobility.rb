module Walkable
  def walk
    if self.class == Noble
      "#{title} #{name} #{gait} forward"
    else
      "#{name} #{gait} forward"
    end
  end
end

class Noble
  include Walkable

  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end
  
  def gait
    'struts'
  end
end

byron = Noble.new('Byron', 'Lord')
p byron.walk
p byron.name
p byron.title
