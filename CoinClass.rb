class Coin

  def initialize(diameterIn, massIn)
    @diameter = diameterIn
    @mass = massIn
  end

  def getDiameter()
    @diameter
  end

  def getMass()
    @mass
  end

end

class Penny < Coin

  def initialize()
    @diameter = 19.05
    @mass = 2.5
  end

end

class Nickel < Coin

  def initialize()
    @diameter = 21.21
    @mass = 5
  end

end

class Dime < Coin

  def initialize()
    @diameter = 17.91
    @mass = 2.5
  end

end

class Quarter < Coin

  def initialize()
    # assuming current design of cupronickel
    @diameter = 24.26
    @mass = 5.67
  end

end

class FakeQuarter < Coin

  def initialize()
    @diameter = 24.25
    @mass = 5.67
  end

end
