require_relative "CoinClass"

class VendingMachine
  @@colaPrice = 1.0
  @@chipsPrice = 0.5
  @@candyPrice = 0.65

  def initialize()
    @displayText = "INSERT COIN"
    @numberOfCola = 0
    @numberOfChips = 0
    @numberOfCandy = 0
    @amountDeposited = 0
    @coinReturn = []
    @coinsAccepted = []
  end

  def checkDisplay()
    textOut = @displayText
    if textOut == "THANK YOU"
      @displayText = "INSERT COIN"
    elsif textOut.include?("PRICE") || textOut == "SOLD OUT"
      @displayText = ("\$%0.2f" % [@amountDeposited])
    end
    textOut
  end

  def acceptCoin(coinObject)
    case coinObject.getDiameter()
    when 24.26
      @amountDeposited += 0.25
      @coinsAccepted << coinObject
    when 17.91
      @amountDeposited += 0.1
      @coinsAccepted << coinObject
    when 21.21
      @amountDeposited += 0.05
      @coinsAccepted << coinObject
    else
      @coinReturn << coinObject
    end
    if @amountDeposited > 0
      @displayText = ("\$%0.2f" % [@amountDeposited])
    else
      @displayText = "INSERT COIN"
    end
  end

  def colaButtonPressed()
    if @numberOfCola > 0
      priceCheck(@@colaPrice)
    else #@numberOfCola == 0
      @displayText = "SOLD OUT"
    end
  end

  def chipsButtonPressed()
    if @numberOfChips > 0
      priceCheck(@@chipsPrice)
    else #numberOfChips == 0
      @displayText = "SOLD OUT"
    end
  end

  def candyButtonPressed()
    if @numberOfCandy > 0
      priceCheck(@@candyPrice)
    else #numberOfChips == 0
      @displayText = "SOLD OUT"
    end
  end

  def checkCoinReturn()
    coinsToReturn = @coinReturn
    @coinReturn = []
    coinsToReturn
  end

  def requestCoinReturn()
    @coinReturn += @coinsAccepted
    @coinsAccepted = []
    @displayText = "INSERT COIN"
  end

  def adjustColaStock(numberOfCola)
    @numberOfCola += numberOfCola
  end

  def adjustChipsStock(numberOfChips)
    @numberOfChips += numberOfChips
  end

  def adjustCandyStock(numberOfCandy)
    @numberOfCandy += numberOfCandy
  end

private

    def priceCheck(price)
      if @amountDeposited < price
        @displayText = "PRICE \$%0.2f" % [price]
      elsif @amountDeposited == price
        @displayText = "THANK YOU"
      elsif @amountDeposited > price
        @displayText = "THANK YOU"
        makeChange((@amountDeposited - price).round(2))
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
