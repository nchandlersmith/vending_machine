require_relative "coin"
require_relative "display"

class VendingMachine

  def initialize(displayObject)
    @display = displayObject
    @numberOfQuarters = 0
  end

  def checkDisplay()
    @display.getDisplayText()
  end

  def acceptCoin(coinObject)
    # just use diameter for now
    # extend to mass for improved fake coin detection
    case coinObject.getDiameter()
    when 24.26
      @numberOfQuarters += 1
      # cashOnHand should be a module call
      cashOnHand = @numberOfQuarters * 0.25
      @display.setDisplayText("#{cashOnHand}")
    else
    end
  end


end
