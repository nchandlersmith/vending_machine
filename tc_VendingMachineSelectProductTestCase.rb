require_relative "CoinClass"
require_relative "VendingMachineTestClass"

class SelectProductTest < VendingMachineTest

  def test_SelectProductDispenseColaCheckDisplay
    for i in 1..4
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptColaPurchase()
  end

  def test_SelectProductDispenseColaAfterMoreMoneyCheckDisplay
    insertCoinAndVerifyDisplay(@quarter)
    attemptColaPurchase()
    for i in 2..4
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptColaPurchase()
  end

  def test_SelectProductDispenseChipsCheckDisplay
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    attemptChipsPurchase()
  end

  def test_SelectProductDispenseChipsAfterMoreMoneyCheckDisplay
    insertCoinAndVerifyDisplay(@quarter)
    attemptChipsPurchase()
    insertCoinAndVerifyDisplay(@quarter)
    attemptChipsPurchase()
  end

  def test_SelectProductDispenseCandyCheckDisplay
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@nickel)
    attemptCandyPurchase()
  end

  def test_SelectProductDisenseCandyAfterMoreMoneyCheckDisplay
    insertCoinAndVerifyDisplay(@nickel)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@quarter)
    attemptCandyPurchase()
    insertCoinAndVerifyDisplay(@quarter)
    attemptCandyPurchase()
  end

  def test_SelectProductNotEnoughMoneyCheckDisplay
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

  def test_SelectProductDispenseColaChipsCandy
    for i in 1..4
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptColaPurchase()
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    attemptChipsPurchase()
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@nickel)
    attemptCandyPurchase()
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    attemptCandyPurchase()
  end

end
