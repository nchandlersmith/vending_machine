require_relative "coin"
require_relative "display"

class VendingMachine
  @@colaPrice = 1.0
  @@chipsPrice = 0.5
  @@candyPrice = 0.65

  def initialize()
    @display = Display.new()
    @numberOfQuarters = 0
    @numberOfDimes = 0
    @numberOfNickels = 0
    @cashOnHand = 0
    @coinReturn = []
  end

  def checkDisplay()
    textOut = @display.getDisplayText()
    if textOut == "THANK YOU"
      @display.setDisplayText("INSERT COIN")
    elsif textOut.include?("PRICE")
      @display.setDisplayText("\$%0.2f" % [@cashOnHand])
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
      @coinReturn << coinObject
    end

    @cashOnHand = @numberOfNickels * 0.05 \
                  + @numberOfDimes * 0.1 \
                  + @numberOfQuarters * 0.25

    if @cashOnHand > 0
      @display.setDisplayText("\$%0.2f" % [@cashOnHand])
    else
      @display.setDisplayText("INSERT COIN")
    end
  end

  def colaButtonPressed()
    priceCheck(@@colaPrice)
  end

  def chipsButtonPressed()
    priceCheck(@@chipsPrice)
  end

  def candyButtonPressed()
    priceCheck(@@candyPrice)
  end

  def checkCoinReturn()
    @coinReturn
  end

private

    def priceCheck(price)
      if @cashOnHand < price
        @display.setDisplayText("PRICE \$%0.2f" % [price])
      elsif @cashOnHand == price
        @display.setDisplayText("THANK YOU")
      else
        @display.setDisplayText("THANK YOU")
        makeChange((@cashOnHand - price).round(2))
      end
    end

    def makeChange(changeAmount)
      numberOfQuarters = (changeAmount / 0.25).floor
      changeAmount = (((changeAmount / 0.25) - numberOfQuarters) * 0.25).round(2)
      numberOfDimes = (changeAmount / 0.1).floor
      changeAmount = (((changeAmount / 0.1) - numberOfDimes) * 0.1).round(2)
      numberOfNickels = (changeAmount / 0.05).floor
      for i in 1..numberOfQuarters
        @coinReturn << Quarter.new()
      end
      for i in 1..numberOfDimes
        @coinReturn << Dime.new()
      end
      for i in 1..numberOfNickels
        @coinReturn << Nickel.new()
      end
    end

end
