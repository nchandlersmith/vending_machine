require_relative "CoinClass"
require_relative "VendingMachineTestClass"

class ExactChangeOnly < VendingMachineTest

  def test_ExactChangeOnlyNoDimesOneNickelsDisplayExactChangeOnly
    @vending_machine.adjustDimeBank(-10)
    @vending_machine.adjustNickelBank(-9)
    assert_equal("EXACT CHANGE ONLY", @vending_machine.checkDisplay())
  end

  def test_ExactChangeOnlyNoNickels1DimeDisplayInsertCoin
    @vending_machine.adjustDimeBank(-9)
    @vending_machine.adjustNickelBank(-10)
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_ExactChangeOnly2NickelsNoDimesDisplayInsertCoin
    @vending_machine.adjustDimeBank(-10)
    @vending_machine.adjustNickelBank(-8)
    assert_equal("INSERT COIN", @vending_machine.checkDisplay())
  end

  def test_ExactChangeOnlyAfterCandyPurchaseReturnsDime
    @vending_machine.adjustDimeBank(-9)
    @vending_machine.adjustNickelBank(-10)
    for i in 1..3
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptCandyPurchase()
    assert_equal("EXACT CHANGE ONLY", @vending_machine.checkDisplay())
  end

  def test_ExactChangeOnlyAfterCandyPurchaseReturnsANickel
    @vending_machine.adjustDimeBank(-10)
    @vending_machine.adjustNickelBank(-8)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@quarter)
    insertCoinAndVerifyDisplay(@dime)
    insertCoinAndVerifyDisplay(@dime)
    attemptCandyPurchase()
    assert_equal("EXACT CHANGE ONLY", @vending_machine.checkDisplay())
  end

  def test_ExactChangeOnlyAfterCandyPurchaseReturns2NickelsBecauseMachineOutOfDimes
    @vending_machine.adjustDimeBank(-10)
    @vending_machine.adjustNickelBank(-7)
    for i in 1..3
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptCandyPurchase()
    assert_equal("EXACT CHANGE ONLY", @vending_machine.checkDisplay())
  end

  def test_ExactChangeOnlyAfterChipsPurchaseReturnsDimesBecauseOutOfQuarters
    @vending_machine.adjustQuarterBank(-10)
    @vending_machine.adjustDimeBank(-5)
    @vending_machine.adjustNickelBank(-10)
    for i in 1..4
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptChipsPurchase()
    assert_equal("EXACT CHANGE ONLY", @vending_machine.checkDisplay())
  end

  def test_ExactChangeOnlyAfterChipsPurchaseReturnsNickelsAndDimes
    @vending_machine.adjustQuarterBank(-10)
    @vending_machine.adjustDimeBank(-9)
    @vending_machine.adjustNickelBank(-6)
    for i in 1..3
      insertCoinAndVerifyDisplay(@quarter)
    end
    attemptChipsPurchase()
    assert_equal("EXACT CHANGE ONLY", @vending_machine.checkDisplay())
  end

end
