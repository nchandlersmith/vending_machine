class Coin
  def initialize(sizeIn, weightIn)
    @size = sizeIn #mm
    @weight = weightIn #grams
  end

  def getSize()
    @size
  end

  def getWeight()
    @weight
  end
end
