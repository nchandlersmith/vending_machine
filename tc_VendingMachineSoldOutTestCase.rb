require_relative "tc_CoinTestCase"
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

  def attemptCandyPurchaseWhenSoldOut()
    @vending_machine.candyButtonPressed()
    verifyPurchaseAttemptWhenSoldOut()
  end

  def test_VendingMachineSoldOutPurchaseColaAtPrice
    @vending_machine.adjustColaStock(-1)
    for i in 1..4
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptColaPurchaseWhenSoldOut()
  end

  def test_VendingMachineSoldOutPurchaseChipsAtPrice
    @vending_machine.adjustChipsStock(-1)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    attemptChipsPurchaseWhenSoldOut()
  end

  def test_VendingMachineSoldOutPurchaseCandyAtPrice
    @vending_machine.adjustCandyStock(-1)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@nickel)
    attemptCandyPurchaseWhenSoldOut()
  end

end
