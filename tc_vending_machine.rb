require_relative "tc_coin"
require_relative "vending_machine"
require "test/unit"

class TestVendingMachine < Test::Unit::TestCase

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
    coinReturned = @vending_machine.checkCoinReturn()
    assert_instance_of(Penny, coinReturned.pop())
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

  def test_VendingMachineSelectProductNotEnoughMoney
    insertCoinAndVerifyDisplay(@nickel)
    attemptChipsPurchase()
    assert_equal("\$0.05", @vending_machine.checkDisplay())
    insertCoinAndVerifyDisplay(@dime)
    attemptCandyPurchase()
    assert_equal("\$0.15", @vending_machine.checkDisplay())
    insertCoinAndVerifyDisplay(@quarter)
    attemptColaPurchase()
    assert_equal("\$0.40", @vending_machine.checkDisplay())
  end

  def test_VendingMachineMakeChangePurchaseCandyWith70CentsGet5CentsBack
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@dime)
    attemptCandyPurchase()
  end

  def test_VendingMachineMakeChangePurchaseChipsWith65CentsGet15CentsBack
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@nickel)
    attemptChipsPurchase()
  end

  def test_VendingMachineMakeChangePurchaseColaWith140CentsGet40CentsBack
    for i in 1..5
      insertCoinAndVerifyDisplay(@quarter)
    end
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@nickel)
    attemptColaPurchase()
  end

  def test_VendingMachineReturnCoins1Quarter
    insertCoinAndVerifyDisplay(@quarter)
    @vending_machine.requestCoinReturn()
    returnInCoins = @vending_machine.checkCoinReturn()
    assert_instance_of(Quarter, returnInCoins[0])
    assert_equal(1, returnInCoins.count())
  end

  def test_VendingMachineReturnCoins1Quarter1Dime
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    @vending_machine.requestCoinReturn()
    returnInCoins = @vending_machine.checkCoinReturn()
    assert_instance_of(Quarter, returnInCoins[0])
    assert_instance_of(Dime, returnInCoins[1])
    assert_equal(2, returnInCoins.count())
  end

    def test_VendingMachineReturnCoins1Quarter1Penny1Dime1Nickel
      insertCoinAndVerifyDisplay(@quarter)
      insertCoinAndVerifyDisplay(@penny)
      insertCoinAndVerifyDisplay(@dime)
      insertCoinAndVerifyDisplay(@nickel)
      @vending_machine.requestCoinReturn()
      returnInCoins = @vending_machine.checkCoinReturn()
      assert_instance_of(Penny, returnInCoins[0])
      assert_instance_of(Quarter, returnInCoins[1])
      assert_instance_of(Dime, returnInCoins[2])
      assert_instance_of(Nickel, returnInCoins[3])
      assert_equal(4, returnInCoins.count())
    end

end
