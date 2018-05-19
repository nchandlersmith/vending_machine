require_relative "coin"

class VendingMachine
  @@colaPrice = 1.0
  @@chipsPrice = 0.5
  @@candyPrice = 0.65

  def initialize()
    @displayText = "INSERT COIN"
    @numberOfQuarters = 0
    @numberOfDimes = 0
    @numberOfNickels = 0
    @cashOnHand = 0
    @coinReturn = []
  end

  def checkDisplay()
    textOut = @displayText
    if textOut == "THANK YOU"
      @displayText = "INSERT COIN"
    elsif textOut.include?("PRICE")
      @displayText = ("\$%0.2f" % [@cashOnHand])
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
      @displayText = ("\$%0.2f" % [@cashOnHand])
    else
      @displayText = "INSERT COIN"
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

  def requestCoinReturn()
    @coinReturn << Quarter.new()
  end

private

    def priceCheck(price)
      if @cashOnHand < price
        @displayText = "PRICE \$%0.2f" % [price]
      elsif @cashOnHand == price
        @displayText = "THANK YOU"
      elsif @cashOnHand > price
        @displayText = "THANK YOU"
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
