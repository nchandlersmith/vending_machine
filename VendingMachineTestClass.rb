require_relative "VendingMachineClass"
require "test/unit"

class VendingMachineTest < Test::Unit::TestCase

  def setup
    @penny = Penny.new()
    @nickel = Nickel.new()
    @dime = Dime.new()
    @quarter = Quarter.new()
    @vending_machine = VendingMachine.new()
    @amountMoneyAccepted = 0
    @colaPrice = 1.0
    @chipsPrice = 0.5
    @candyPrice = 0.65
    @vending_machine.adjustColaStock(1)
    @vending_machine.adjustChipsStock(1)
  end

  # Helper functions
  def updateAmountMoneyAccepted(coinObject)
    if coinObject.is_a?(Quarter)
      @amountMoneyAccepted += 0.25
    elsif coinObject.is_a?(Dime)
      @amountMoneyAccepted += 0.10
    elsif coinObject.is_a?(Nickel)
      @amountMoneyAccepted += 0.05
    end
  end

  def verifyDisplayTextAfterCoinInserted()
    if @amountMoneyAccepted == 0
      assert_equal("INSERT COIN", @vending_machine.checkDisplay())
    else
      assert_equal("\$%0.2f" % [@amountMoneyAccepted], @vending_machine.checkDisplay)
    end
  end

  def insertCoinAndVerifyDisplay(coinObject)
    @vending_machine.acceptCoin(coinObject)
    updateAmountMoneyAccepted(coinObject)
    verifyDisplayTextAfterCoinInserted()
  end

  def verifyPurchaseAttempt(price)
    if @amountMoneyAccepted < price
      assert_equal("PRICE \$%0.2f" % [price], @vending_machine.checkDisplay())
    elsif @amountMoneyAccepted >= price
      assert_equal("THANK YOU", @vending_machine.checkDisplay())
      assert_equal("INSERT COIN", @vending_machine.checkDisplay())
      if @amountMoneyAccepted > price
        changeInCoins = @vending_machine.checkCoinReturn()
        changeInDollars = coinsToDollars(changeInCoins)
        expectedChange = (@amountMoneyAccepted - price).round(2)
        assert_equal(expectedChange, changeInDollars.round(2))
      end
    end
  end

  def coinsToDollars(coinArray)
    dollars = 0
    for coin in coinArray
      if coin.is_a?(Quarter)
        dollars += 0.25
      elsif coin.is_a?(Dime)
        dollars += 0.1
      elsif coin.is_a?(Nickel)
        dollars += 0.05
      end
    end
    dollars
  end

  def attemptColaPurchase()
    @vending_machine.colaButtonPressed()
    verifyPurchaseAttempt(@colaPrice)
  end

  def attemptChipsPurchase()
    @vending_machine.chipsButtonPressed()
    verifyPurchaseAttempt(@chipsPrice)
  end

  def attemptCandyPurchase()
    @vending_machine.candyButtonPressed()
    verifyPurchaseAttempt(@candyPrice)
  end

end
