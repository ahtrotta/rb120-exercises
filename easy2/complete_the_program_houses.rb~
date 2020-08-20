module HouseCompare
  def <(other_house)
    self.price < other_house.price
  end

  def >(other_house)
    self.price > other_house.price
  end
end

#class House
#  include HouseCompare
#
#  attr_reader :price
#
#  def initialize(price)
#    @price = price
#  end
#end

# Launch School solution

class House
  include Comparable

  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other_house)
    price <=> other_house.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1
