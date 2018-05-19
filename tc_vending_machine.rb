require_relative "tc_coin"
require_relative "tc_display"
require_relative "vending_machine"
require "test/unit"

class TestVendingMachine < Test::Unit::TestCase

  def setup
    @penny = Penny.new()
    @nickel = Nickel.new()
    @dime = Dime.new()
    @quarter = Quarter.new()
    @display = Display.new()
    @vending_machine = VendingMachine.new(@display)
    @amountMoneyAccepted = 0
    @colaPrice = 1.0
    @chipsPrice = 0.5
    @candyPrice = 0.65
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
    if @amountMoneyAccepted == price
      assert_equal("THANK YOU", @vending_machine.checkDisplay())
      assert_equal("INSERT COIN", @vending_machine.checkDisplay())
    elsif @amountMoneyAccepted < price
      assert_equal("PRICE \$%0.2f" % [price], @vending_machine.checkDisplay())
    end
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

  # Tests start here
  def test_VendingMachineAcceptCoinNoCoinsInserted
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_VendingMachineAcceptCoinQuarter
    insertCoinAndVerifyDisplay(@quarter)
  end

  def test_VendingMachineAcceptCoinDime
    insertCoinAndVerifyDisplay(@dime)
  end

  def test_VendingMachineAcceptCoinNickel
    insertCoinAndVerifyDisplay(@nickel)
  end

  def test_VendingMachineRejectPenny
    insertCoinAndVerifyDisplay(@penny)
  end

  def test_VendingMachineRejectPenniesAcceptValidCoins
    insertCoinAndVerifyDisplay(@penny)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@penny)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@penny)
    insertCoinAndVerifyDisplay(@nickel)
    insertCoinAndVerifyDisplay(@penny)
  end

  def test_VendingMachineSelectProductDispenseCola
    for i in 1..4
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptColaPurchase()
  end

  def test_VendingMachineSelectProductDispenseColaAfterMoreMoney
    insertCoinAndVerifyDisplay(@quarter)
    attemptColaPurchase()
    for i in 2..4
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptColaPurchase()
  end

  def test_VendingMachineSelectProductDispenseChips
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    attemptChipsPurchase()
  end

  def test_VendingMachineSelectProductDispenseChipsAfterMoreMoney
    insertCoinAndVerifyDisplay(@quarter)
    attemptChipsPurchase()
    insertCoinAndVerifyDisplay(@quarter)
    attemptChipsPurchase()
  end

  def test_VendingMachineSelectProductDispenseCandy
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@nickel)
    attemptCandyPurchase()
  end

  def test_VendingMachineSelectProductDisenseCandyAfterMoreMoney
    insertCoinAndVerifyDisplay(@nickel)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@quarter)
    attemptCandyPurchase()
    insertCoinAndVerifyDisplay(@quarter)
    attemptCandyPurchase()
  end
    
end
