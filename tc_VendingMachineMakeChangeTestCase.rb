require_relative "CoinClass"
require_relative "VendingMachineTestClass"

class MakeChangeTest < VendingMachineTest

  def test_VendingMachineMakeChangePurchaseCandyWith70CentsGet5CentsBack
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@dime)
    attemptCandyPurchase()
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_VendingMachineMakeChangePurchaseChipsWith65CentsGet15CentsBack
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@nickel)
    attemptChipsPurchase()
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_VendingMachineMakeChangePurchaseColaWith140CentsGet40CentsBack
    for i in 1..5
      insertCoinAndVerifyDisplay(@quarter)
    end
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@nickel)
    attemptColaPurchase()
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

end
