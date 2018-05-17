require_relative "coin"
require_relative "display"

class VendingMachine

  def initialize(displayObject)
    @display = displayObject
    @numberOfQuarters = 0
    @numberOfDimes = 0
    @numberOfNickels = 0
    @cashOnHand
  end

  def checkDisplay()
    if @display.getDisplayText() == "THANK YOU"
      textOut = "THANK YOU"
      @display.setDisplayText("INSERT COIN")
    else
      textOut = @display.getDisplayText()
    end

    textOut
  end

  def acceptCoin(coinObject)
    case coinObject.getDiameter()
    when 24.26
      @numberOfQuarters += 1
    when 17.91
      @numberOfDimes += 1
    when 21.21
      @numberOfNickels += 1
    else
      # Do nothing. Invalid coin entered and will be placed in return.
    end

    @cashOnHand = @numberOfNickels * 0.05 + @numberOfDimes * 0.1 + @numberOfQuarters * 0.25

    if @cashOnHand > 0
      @display.setDisplayText("\$%0.2f" % [@cashOnHand])
    else
      @display.setDisplayText("INSERT COIN")
    end
  end

  def colaButtonPressed()
    if @cashOnHand < 1
      @display.setDisplayText("PRICE $1.00")
    else
      @display.setDisplayText("THANK YOU")
    end
  end

end
