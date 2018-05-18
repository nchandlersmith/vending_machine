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

  def verifyDisplayText()
    if @amountMoneyAccepted == 0
      assert_equal("INSERT COIN", @vending_machine.checkDisplay())
    else
      assert_equal("\$%0.2f" % [@amountMoneyAccepted], @vending_machine.checkDisplay)
    end
  end

  def insertCoinAndTestDisplay(coinObject)
    @vending_machine.acceptCoin(coinObject)
    updateAmountMoneyAccepted(coinObject)
    verifyDisplayText()
  end

  # Tests start here
  def test_VendingMachineAcceptCoinNoCoinsInserted
    verifyDisplayText()
  end

  def test_VendingMachineAcceptCoinQuarter
    insertCoinAndTestDisplay(@quarter)
  end

  def test_VendingMachineAcceptCoinDime
    insertCoinAndTestDisplay(@dime)
  end

  def test_VendingMachineAcceptCoinNickel
    insertCoinAndTestDisplay(@nickel)
  end

  def test_VendingMachineRejectPenny
    insertCoinAndTestDisplay(@penny)
  end

  def test_VendingMachineRejectPenniesAcceptValidCoins
    insertCoinAndTestDisplay(@penny)
    insertCoinAndTestDisplay(@quarter)
    insertCoinAndTestDisplay(@penny)
    insertCoinAndTestDisplay(@dime)
    insertCoinAndTestDisplay(@penny)
    insertCoinAndTestDisplay(@nickel)
    insertCoinAndTestDisplay(@penny)
  end

  def test_VendingMachineSelectProductDispenseCola
    for i in 1..4
      insertCoinAndTestDisplay(@quarter)
    end
    @vending_machine.colaButtonPressed()
    assert_equal("THANK YOU", @vending_machine.checkDisplay())
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_VendingMachineSelectProductDispenseColaAfterPriceCheck
    @vending_machine.acceptCoin(@quarter)
    assert_equal("$0.25", @vending_machine.checkDisplay())
    @vending_machine.colaButtonPressed()
    assert_equal("PRICE $1.00", @vending_machine.checkDisplay())
    for i in 2..4
      @vending_machine.acceptCoin(@quarter)
      assert_equal("\$%0.2f" % [i * 0.25], @vending_machine.checkDisplay())
    end
    @vending_machine.colaButtonPressed()
    assert_equal("THANK YOU", @vending_machine.checkDisplay())
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_VendingMachineSelectProductDispenseChips
    @vending_machine.acceptCoin(@quarter)
    @vending_machine.acceptCoin(@quarter)
    @vending_machine.chipsButtonPressed()
    assert_equal("THANK YOU", @vending_machine.checkDisplay())
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_VendingMachineSelectProductDispenseChipsAfterPriceCheck
    @vending_machine.acceptCoin(@quarter)
    assert_equal("$0.25", @vending_machine.checkDisplay())
    @vending_machine.chipsButtonPressed()
    assert_equal("PRICE $0.50", @vending_machine.checkDisplay())
    @vending_machine.acceptCoin(@quarter)
    assert_equal("$0.50", @vending_machine.checkDisplay())
    @vending_machine.chipsButtonPressed()
    assert_equal("THANK YOU", @vending_machine.checkDisplay())
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_VendingMachineSelectProductDispenseCandy
    @vending_machine.acceptCoin(@quarter)
    assert_equal("$0.25", @vending_machine.checkDisplay())
    @vending_machine.acceptCoin(@quarter)
    assert_equal("$0.50", @vending_machine.checkDisplay())
    @vending_machine.acceptCoin(@dime)
    assert_equal("$0.60", @vending_machine.checkDisplay())
    @vending_machine.acceptCoin(@nickel)
    assert_equal("$0.65", @vending_machine.checkDisplay())
    @vending_machine.candyButtonPressed()
    assert_equal("THANK YOU", @vending_machine.checkDisplay())
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

end
