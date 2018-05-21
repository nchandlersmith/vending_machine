require_relative "CoinClass"
require_relative "VendingMachineTestClass"

class SoldOutTest < VendingMachineTest

  def verifyPurchaseAttemptWhenSoldOut()
    assert_equal("SOLD OUT", @vending_machine.checkDisplay())
    assert_equal("\$%0.2f" % [@amountMoneyAccepted], @vending_machine.checkDisplay())
    assert_equal("\$%0.2f" % [@amountMoneyAccepted], @vending_machine.checkDisplay())
  end

  def attemptColaPurchaseWhenSoldOut()
    @vending_machine.colaButtonPressed()
    verifyPurchaseAttemptWhenSoldOut()
  end

  def attemptChipsPurchaseWhenSoldOut()
    @vending_machine.chipsButtonPressed()
    verifyPurchaseAttemptWhenSoldOut()
  end

  def checkCoinReturnForFiveQuarters()
    @vending_machine.requestCoinReturn()
    returnInCoins = @vending_machine.checkCoinReturn()
    for i in 0..4
      assert_instance_of(Quarter, returnInCoins[i])
    end
    assert_equal(5, returnInCoins.count())
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def attemptCandyPurchaseWhenSoldOut()
    @vending_machine.candyButtonPressed()
    verifyPurchaseAttemptWhenSoldOut()
  end

  def test_SoldOutAttemptPurchaseColaAtPrice
    @vending_machine.adjustColaStock(-1)
    for i in 1..4
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptColaPurchaseWhenSoldOut()
  end

  def test_SoldOutAttemptPurchaseChipsAtPrice
    @vending_machine.adjustChipsStock(-1)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    attemptChipsPurchaseWhenSoldOut()
  end

  def test_SoldOutAttemptPurchaseCandyAtPrice
    @vending_machine.adjustCandyStock(-1)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@nickel)
    attemptCandyPurchaseWhenSoldOut()
  end

  def test_SoldOutAttemptPurchaseCandyBelowPrice
    @vending_machine.adjustCandyStock(-1)
    insertCoinAndVerifyDisplay(@quarter)
    attemptCandyPurchaseWhenSoldOut
  end

  def test_SoldOutAttemptPurchaseChipsBelowPrice
    @vending_machine.adjustChipsStock(-1)
    insertCoinAndVerifyDisplay(@nickel)
    attemptChipsPurchaseWhenSoldOut
  end

  def test_SoldOutAttemptPurchaseColaBelowPrice
    @vending_machine.adjustColaStock(-1)
    insertCoinAndVerifyDisplay(@dime)
    attemptColaPurchaseWhenSoldOut()
  end

  def test_SoldOutAttemptPurchaseCandyAbovePrice
    @vending_machine.adjustCandyStock(-1)
    for i in 1..5
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptCandyPurchaseWhenSoldOut()
    checkCoinReturnForFiveQuarters()
  end

  def test_SoldOutAttemptPurchaseChipsAbovePrice
    @vending_machine.adjustChipsStock(-1)
    for i in 1..5
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptChipsPurchaseWhenSoldOut()
    checkCoinReturnForFiveQuarters()
  end

  def test_SoldOutAttemptPurchaseColaAbovePrice
    @vending_machine.adjustColaStock(-1)
    for i in 1..5
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptColaPurchaseWhenSoldOut()
    checkCoinReturnForFiveQuarters()
  end

end
