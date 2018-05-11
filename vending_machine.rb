require_relative "coin"
require_relative "display"

class VendingMachine

  def initialize(displayObject)
    @display = displayObject
    @numberOfQuarters = 0
    @numberOfDimes = 0
  end

  def checkDisplay()
    @display.getDisplayText()
  end

  def acceptCoin(coinObject)
    case coinObject.getDiameter()
    when 24.26
      @numberOfQuarters += 1
    when 17.91
      @numberOfDimes += 1
    else
    end
    cashOnHand = @numberOfDimes * 0.1 + @numberOfQuarters * 0.25
    @display.setDisplayText("%0.2f" % [cashOnHand])
  end

end
